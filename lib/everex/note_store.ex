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
defmodule Everex.NoteStore do
  require Record

  Record.defrecord :note_filter, :NoteFilter,
    Record.extract(:NoteFilter,
      from_lib: "edam/include/note_store_types.hrl")

  Record.defrecord :notes_metadata_result_spec, :NotesMetadataResultSpec,
    Record.extract(:NotesMetadataResultSpec,
      from_lib: "edam/include/note_store_types.hrl")

  Record.defrecord :notes_metadata_list, :NotesMetadataList,
    Record.extract(:NotesMetadataList,
      from_lib: "edam/include/note_store_types.hrl")

  Record.defrecord :note_metadata, :NoteMetadata,
    Record.extract(:NoteMetadata,
      from_lib: "edam/include/note_store_types.hrl")

  Record.defrecord :note, :Note,
    Record.extract(:Note, from_lib: "edam/include/types_types.hrl")

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

  def get_note(client,
               guid,
               with_content \\ false,
               with_resources_data \\ false,
               with_resources_recognition \\ false,
               with_resources_alternate_data \\ false)
  do
    GenServer.call(client, {:notestore, :getNote, [
        guid, with_content, with_resources_data, with_resources_recognition,
        with_resources_alternate_data
      ]})
  end
end
