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
  use Everex.Types
  require Record
  import Everex.Client, only: [thrift_call: 3, thrift_call: 4]

  @doc """
  Lists all the notebooks in the Evernote account.
  """
  def list_notebooks(client) do
    thrift_call(client, :notestore, :listNotebooks)
  end

  @doc """
  Lists all the tags in the Evernote account.
  """
  def list_tags(client) do
    thrift_call(client, :notestore, :listTags)
  end

  @doc """
  Finds notes based on the given filter, with pagination support handled
  by an offset and a limit on max notes returned. By default, all notes
  will be found (empty note filter) and only the guid is returned for each
  result (empty notes metadata result specification).
  """
  def find_notes_metadata(client,
                          filter \\ %Types.NoteFilter{},
                          offset \\ 0,
                          max_notes \\ 100,
                          result_spec \\ %Types.NotesMetadataResultSpec{})
  do
    thrift_call(client, :notestore, :findNotesMetadata, [
        filter, offset, max_notes, result_spec
    ])
  end

  @doc """
  Retrieves a single note given its guid.
  """
  def get_note(client,
               guid,
               with_content \\ false,
               with_resources_data \\ false,
               with_resources_recognition \\ false,
               with_resources_alternate_data \\ false)
  do
    thrift_call(client, :notestore, :getNote, [
        guid, with_content, with_resources_data, with_resources_recognition,
        with_resources_alternate_data
    ])
  end

  @doc"""
  Creates a single notebook
  """
  def create_notebook(client, notebook) do
    draft_notebook = struct(Types.Notebook, Map.to_list(notebook))
    thrift_call(client, :notestore, :createNotebook, [draft_notebook])
  end
end
