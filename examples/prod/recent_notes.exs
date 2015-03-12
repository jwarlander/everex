alias Everex.Client
alias Everex.NoteStore
alias Everex.Types

defmodule ListNotes do
  def run do
    # Empty filter will retrieve all notes
    filter = %Types.NoteFilter{order: 1, ascending: false}

    # For each result, include title in addition to the guid
    spec = %Types.NotesMetadataResultSpec{includeTitle: true}

    # Start a new client and find the note metadata
    {:ok, client} = Client.new(System.get_env("EN_DEVELOPER_TOKEN"))
    {:ok, notemeta} = NoteStore.find_notes_metadata(client, filter, 0, 100,  spec)

    IO.puts("Found #{notemeta.totalNotes} notes:\n")

    # Extract a list of notes from the search result
    notes = notemeta.notes
    # Find the longest title
    max_length = notes |> Enum.reduce(0, fn(n, l) -> max(l, String.length(n.title)) end)
    # Make a format string using max_length
    fmt = "~-#{max_length}ts | ~s~n"
    # Print all the note titles along with their guids
    notes |> Enum.map(fn x -> :io.format(fmt, [x.title, x.guid]) end)
  end
end

ListNotes.run
