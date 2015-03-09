defmodule OAuth do
  defmodule Request do
    defstruct url: nil, headers: nil, params: nil
  end

  def make_authorization_url(temp_token) do
    url = "https://sandbox.evernote.com/OAuth.action?oauth_token="
    url <> temp_token
  end

  def request_temporary_token do
    temp_req_params = [{"oauth_callback", "http://localhost:4000/oauth_callback"}]
    temp_req_url = "https://sandbox.evernote.com/oauth"

    req = OAuth.sign_request("get", temp_req_url, temp_req_params)
    response = HTTPoison.get!(req.url, req.headers, req.params)

    response.body |> String.split("&") |> Enum.into(
      %{}, fn x -> String.split(x, "=") |> List.to_tuple end
    ) |> Map.fetch!("oauth_token")
  end

  def sign_request(action, url, params) do
    oauth_creds = OAuther.credentials([
      consumer_key: System.get_env("EN_CONSUMER_KEY"),
      consumer_secret: System.get_env("EN_CONSUMER_SECRET"),
      method: :plaintext,
    ])
    signed_params = OAuther.sign(action, url, params, oauth_creds)
    {auth_header, params} = OAuther.header(signed_params)
    %Request{url: url, headers: [auth_header], params: params}
  end
end

defmodule OAuth.CallbackHandler do
  use Plug.Router

  def start do
    Plug.Adapters.Cowboy.http(OAuth.CallbackHandler, nil, port: 4000)
  end

  plug :match
  plug :dispatch

  get "/oauth_callback" do
    conn
    |> Plug.Conn.fetch_params
    |> process_params
    |> respond
  end

  def process_params(conn) do
    Plug.Conn.assign(conn, :response, "PARAMS: #{inspect(conn.params)}")
    # make a request for the real token:
    # https://sandbox.evernote.com/oauth?oauth_consumer_key=...&oauth_signature=...&oauth_signature_method=PLAINTEXT&oauth_timestamp=1288364923&oauth_nonce=755d38e6d163e820&oauth_token=ABC&oauth_verifier=XYZ
  end

  def respond(conn) do
    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    #|> Plug.Conn.send_resp(200, "Hello, World!")
    |> Plug.Conn.send_resp(200, conn.assigns[:response])
  end
end

temp_token = OAuth.request_temporary_token
authorization_url = OAuth.make_authorization_url(temp_token)

IO.puts("\nPlease visit:")
IO.puts("  #{authorization_url}")

OAuth.CallbackHandler.start

IO.puts("\nWaiting for 60 seconds..")
receive do
  after 60_000 -> :timeout
end
