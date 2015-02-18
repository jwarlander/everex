defmodule EverexTest do
  use ExUnit.Case

  require Everex.NoteStore
  require Record

  alias Everex.Client
  alias Everex.NoteStore

  @developer_token System.get_env("EN_DEVELOPER_TOKEN")

  test "retrieve notestore url using our API" do
    {:ok, client} = Everex.Client.new(@developer_token, sandbox: true)

    {:ok, url} = GenServer.call(
      client, {:userstore, :getNoteStoreUrl, []}
    )

    [prefix, postfix] = String.split(url, ~r"/s[0-9]+/")
    assert prefix == "https://sandbox.evernote.com/shard"
    assert postfix == "notestore"
  end

  test "list tags" do
    {:ok, client} = Everex.Client.new(@developer_token, sandbox: true)
    {:ok, tags} = Everex.NoteStore.list_tags(client)
    case Enum.count(tags) do
      0 -> true
      _else -> 
        first = Enum.at(tags, 0)
        assert Record.is_record(first, :Tag)
    end
  end

  test "list notebooks" do
    {:ok, client} = Everex.Client.new(@developer_token, sandbox: true)
    {:ok, notebooks} = Everex.NoteStore.list_notebooks(client)
    case Enum.count(notebooks) do
      0 -> true
      _else -> 
        first = Enum.at(notebooks, 0)
        assert Record.is_record(first, :Notebook)
    end
  end

  test "find note metadata" do
    {:ok, client} = Everex.Client.new(@developer_token, sandbox: true)
    {:ok, notes} = Everex.NoteStore.find_notes_metadata(client)
    assert Record.is_record(notes, :NotesMetadataList)
  end

  test "get note" do
    {:ok, client} = Client.new(@developer_token, sandbox: true)
    {:ok, notelist} = NoteStore.find_notes_metadata(client)
    noteguid = NoteStore.notes_metadata_list(notelist, :notes)
                |> Enum.at(0)
                |> NoteStore.note_metadata(:guid)

    {:ok, note} = NoteStore.get_note(client, noteguid)

    assert Record.is_record(note, :Note)
  end
end
