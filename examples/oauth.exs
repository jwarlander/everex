defmodule OAuth do
  defmodule Request do
    defstruct url: nil, headers: nil, params: nil
  end

  def make_authorization_url(temp_token) do
    url = "https://sandbox.evernote.com/OAuth.action?oauth_token="
    url <> temp_token
  end

  def request_temporary_token do
    oauth_creds = OAuther.credentials([
      consumer_key: System.get_env("EN_CONSUMER_KEY"),
      consumer_secret: System.get_env("EN_CONSUMER_SECRET"),
      method: :plaintext,
    ])

    req_params = [{"oauth_callback", "http://localhost:4000/oauth_callback"}]
    req_url = "https://sandbox.evernote.com/oauth"

    req = OAuth.sign_request("get", req_url, req_params, oauth_creds)
    response = HTTPoison.get!(req.url, req.headers, req.params)

    response.body |> String.split("&") |> Enum.into(
      %{}, fn x -> String.split(x, "=") |> List.to_tuple end
    ) |> Map.fetch!("oauth_token")
  end

  def request_final_token(token, verifier) do
    oauth_creds = OAuther.credentials([
      consumer_key: System.get_env("EN_CONSUMER_KEY"),
      consumer_secret: System.get_env("EN_CONSUMER_SECRET"),
      token: token,
      method: :plaintext,
    ])

    req_params = [{"oauth_verifier", verifier}]
    req_url = "https://sandbox.evernote.com/oauth"

    req = OAuth.sign_request("get", req_url, req_params, oauth_creds)
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
    result = OAuth.request_final_token(
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

defmodule ListNotesOauth do
  def run do
    case File.exists?(".en_auth") do
      false ->
        temp_token = OAuth.request_temporary_token
        authorization_url = OAuth.make_authorization_url(temp_token)

        IO.puts("\nPlease visit:")
        IO.puts("  #{authorization_url}")

        OAuth.CallbackHandler.start

        IO.puts("\nWaiting for 60 seconds..")
        receive do
        after 60_000 -> :timeout
        end
      true ->
        IO.puts("Already authenticated, proceeding.")
    end


    # Empty filter will retrieve all notes
    filter = %Everex.Types.NoteFilter{}

    # For each result, include title in addition to the guid
    spec = %Everex.Types.NotesMetadataResultSpec{includeTitle: true}

    en_auth = File.read!(".en_auth") |> :erlang.binary_to_term
    {:ok, client} = Everex.Client.new(en_auth["oauth_token"], sandbox: true)
    {:ok, notemeta} = Everex.NoteStore.find_notes_metadata(client, filter, 0, 100,  spec)

    IO.puts("Found #{notemeta.totalNotes} notes:\n")

    # Extract a list of notes from the search result
    notes = notemeta.notes
    # Find the longest title
    max_length = notes |> Enum.reduce(
    0, fn(n, l) -> max(l, String.length(n.title)) end
    )
    # Make a format string using max_length
    fmt = "~-#{max_length}s | ~s~n"
    # Print all the note titles along with their guids
    notes |> Enum.map(fn x -> :io.format(fmt, [x.title, x.guid]) end)
  end
end

ListNotesOauth.run
