defmodule OAuthCallbackHandler do
  use Plug.Router

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
  end

  def respond(conn) do
    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    #|> Plug.Conn.send_resp(200, "Hello, World!")
    |> Plug.Conn.send_resp(200, conn.assigns[:response])
  end
end

oauth_creds = OAuther.credentials([
  consumer_key: System.get_env("EN_CONSUMER_KEY"),
  consumer_secret: System.get_env("EN_CONSUMER_SECRET"),
  method: :plaintext,
])

temp_req_params = [{"oauth_callback", "http://localhost:4000/oauth_callback"}]
temp_req_url = "https://sandbox.evernote.com/oauth"

signed_params = OAuther.sign("get", temp_req_url, temp_req_params, oauth_creds)

IO.inspect signed_params

{auth_header, params} = OAuther.header(signed_params)

IO.inspect {auth_header, params}

response = HTTPoison.get!(temp_req_url, [auth_header], params)

IO.inspect response

temp_token = response.body |> String.split("&") |> Enum.into(
  %{}, fn x -> String.split(x, "=") |> List.to_tuple end
) |> Map.fetch!("oauth_token")

IO.puts("Temporary token:\n  #{IO.inspect(temp_token)}")

authorization_url = "https://sandbox.evernote.com/OAuth.action?oauth_token="
IO.puts("\nPlease visit:")
IO.puts("  #{authorization_url <> temp_token}")

Plug.Adapters.Cowboy.http(OAuthCallbackHandler, nil, port: 4000)

receive do
  after 60_000 -> :timeout
end
