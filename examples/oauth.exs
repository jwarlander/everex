defmodule ListNotesOauth do
  alias Everex.OAuth

  def run do
    case File.exists?(".en_auth") do
      false ->
        temp_token = OAuth.request_temporary_token
        authorization_url = OAuth.make_authorization_url(temp_token)

        IO.puts("\nPlease visit:")
        IO.puts("  #{authorization_url}")

        {:ok, pid} = OAuth.CallbackHandler.start
        Process.monitor(pid)

        IO.puts("\nLocal OAuth callback server started.")
        IO.puts("Waiting for authentication to finish; press CTRL-C to abort.")
        receive do
          {:DOWN, _, :process, ^pid, :shutdown} -> :ok
          msg -> IO.puts("ERROR: #{msg}")
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
