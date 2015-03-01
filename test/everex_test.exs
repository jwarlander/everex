# 
# Copyright 2015 Johan Wärlander
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
defmodule EverexTest do
  use ExUnit.Case

  require Everex.NoteStore

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
        assert first.__struct__ == Everex.Types.Tag
    end
  end

  test "list notebooks" do
    {:ok, client} = Everex.Client.new(@developer_token, sandbox: true)
    {:ok, notebooks} = Everex.NoteStore.list_notebooks(client)
    case Enum.count(notebooks) do
      0 -> true
      _else -> 
        first = Enum.at(notebooks, 0)
        assert first.__struct__ == Everex.Types.Notebook
    end
  end

  test "find note metadata" do
    {:ok, client} = Everex.Client.new(@developer_token, sandbox: true)
    {:ok, notes} = Everex.NoteStore.find_notes_metadata(client)
    assert notes.__struct__ == Everex.Types.NotesMetadataList
  end

  test "get note" do
    {:ok, client} = Client.new(@developer_token, sandbox: true)
    {:ok, notelist} = NoteStore.find_notes_metadata(client)
    notemeta = notelist.notes |> Enum.at(0)

    {:ok, note} = NoteStore.get_note(client, notemeta.guid)

    assert note.__struct__ == Everex.Types.Note
  end

  test "invalid note guid returns exception" do
    {:ok, client} = Client.new(@developer_token, sandbox: true)
    response = NoteStore.get_note(client, "bad_guid")
    assert response == { :exception,
      %Everex.Types.EDAMUserException{errorCode: 2, parameter: "Note.guid"}
    }
  end
end
