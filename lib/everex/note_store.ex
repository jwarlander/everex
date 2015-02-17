defmodule Everex.NoteStore do
  require Record

  Record.defrecord :note_filter, :NoteFilter,
    Record.extract(:NoteFilter,
      from_lib: "edam/include/note_store_types.hrl")

  Record.defrecord :notes_metadata_result_spec, :NotesMetadataResultSpec,
    Record.extract(:NotesMetadataResultSpec,
      from_lib: "edam/include/note_store_types.hrl")

  def list_notebooks(client) do
    GenServer.call(client, {:notestore, :listNotebooks, []})
  end

  def list_tags(client) do
    GenServer.call(client, {:notestore, :listTags, []})
  end

  def find_notes_metadata(client,
                          filter \\ note_filter(),
                          offset \\ 0,
                          max_notes \\ 100,
                          result_spec \\ notes_metadata_result_spec())
  do
    GenServer.call(client, {:notestore, :findNotesMetadata, [
        filter, offset, max_notes, result_spec
      ]})
  end
end
