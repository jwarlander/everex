defmodule Everex.OAuth.Client do

  @production_server "www.evernote.com"
  @sandbox_server "sandbox.evernote.com"

  defstruct server: nil

  defmodule Request do
    defstruct url: nil, headers: nil, params: nil
  end

  def new(opts \\ []) do
    srv = case opts[:sandbox] do
      true -> @sandbox_server
      _else -> @production_server
    end
    state = %__MODULE__{server: srv}
  end

  def make_authorization_url(temp_token) do
    url = "https://sandbox.evernote.com/OAuth.action?oauth_token="
    url <> temp_token
  end

  def request_temporary_token(client = %__MODULE__{server: srv}) do
    oauth_creds = OAuther.credentials([
      consumer_key: System.get_env("EN_CONSUMER_KEY"),
      consumer_secret: System.get_env("EN_CONSUMER_SECRET"),
      method: :plaintext,
    ])

    req_params = [{"oauth_callback", "http://localhost:4000/oauth_callback"}]
    req_url = "https://#{srv}/oauth"

    req = sign_request("get", req_url, req_params, oauth_creds)
    response = HTTPoison.get!(req.url, req.headers, req.params)

    response.body |> String.split("&") |> Enum.into(
      %{}, fn x -> String.split(x, "=") |> List.to_tuple end
    ) |> Map.fetch!("oauth_token")
  end

  def request_final_token(client = %__MODULE__{server: srv}, token,
                          verifier)
  do
    oauth_creds = OAuther.credentials([
      consumer_key: System.get_env("EN_CONSUMER_KEY"),
      consumer_secret: System.get_env("EN_CONSUMER_SECRET"),
      token: token,
      method: :plaintext,
    ])

    req_params = [{"oauth_verifier", verifier}]
    req_url = "https://#{srv}/oauth"

    req = sign_request("get", req_url, req_params, oauth_creds)
    response = HTTPoison.get!(req.url, req.headers, req.params)

    response.body |> String.split("&") |> Enum.into(
      %{}, fn x -> String.split(x, "=") |> List.to_tuple end
    )
  end

  def sign_request(action, url, params, oauth_creds) do
    signed_params = OAuther.sign(action, url, params, oauth_creds)
    {auth_header, params} = OAuther.header(signed_params)
    %Request{url: url, headers: [auth_header], params: params}
  end
end

defmodule Everex.OAuth.CallbackHandler do
  alias Everex.OAuth
  use Plug.Router

  def start do
    Plug.Adapters.Cowboy.http(__MODULE__, nil, port: 4000)
  end

  def shutdown do
    Plug.Adapters.Cowboy.shutdown(OAuth.CallbackHandler.HTTP)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/oauth_callback" do
    conn
    |> Plug.Conn.fetch_params
    |> process_params
    |> respond
    shutdown
  end

  match _ do
    send_resp(conn, 404, "Nothing to see here.")
  end

  def process_params(conn) do
    client = OAuth.Client.new(sandbox: true)
    result = OAuth.Client.request_final_token(
      client,
      conn.params["oauth_token"],
      conn.params["oauth_verifier"]
    ) |> decode_result
    File.write!(".en_auth", :erlang.term_to_binary(result))
    Plug.Conn.assign(conn, :response, """
    <html><body>
    <p>You have successfully granted access to your Evernote account:</p>
    <p><code>#{inspect(result)}</code></p>
    <p>The token has been stored in ".en_auth".</p>
    </body></html>
    """)
  end

  def decode_result(result) do
    Enum.map(result, fn {k,v} -> {k, URI.decode(v)} end)
    |> Enum.into(%{})
  end

  def respond(conn) do
    conn
    |> Plug.Conn.put_resp_content_type("text/html")
    |> Plug.Conn.send_resp(200, conn.assigns[:response])
  end
end
