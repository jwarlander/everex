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

defmodule Evernote.EDAM.Types do
  use Everex.Util

  defmacro __using__(_options) do
    quote do
      alias Evernote.EDAM.Types
      require Types.Note
    end
  end

  # Common Types
  #
  deftype Accounting, :Accounting, from: "include/types_types.hrl"
  deftype BusinessNotebook, :BusinessNotebook, from: "include/types_types.hrl"
  deftype BusinessUserInfo, :BusinessUserInfo, from: "include/types_types.hrl"
  deftype Data, :Data, from: "include/types_types.hrl"
  deftype LazyMap, :LazyMap, from: "include/types_types.hrl"
  deftype LinkedNotebook, :LinkedNotebook, from: "include/types_types.hrl"
  deftype Note, :Note, from: "include/types_types.hrl"
  deftype NoteAttributes, :NoteAttributes, from: "include/types_types.hrl"
  deftype Notebook, :Notebook, from: "include/types_types.hrl"
  deftype NotebookDescriptor, :NotebookDescriptor, from: "include/types_types.hrl"
  deftype NotebookRestrictions, :NotebookRestrictions, from: "include/types_types.hrl"
  deftype PremiumInfo, :PremiumInfo, from: "include/types_types.hrl"
  deftype Publishing, :Publishing, from: "include/types_types.hrl"
  deftype Resource, :Resource, from: "include/types_types.hrl"
  deftype ResourceAttributes, :ResourceAttributes, from: "include/types_types.hrl"
  deftype SavedSearch, :SavedSearch, from: "include/types_types.hrl"
  deftype SavedSearchScope, :SavedSearchScope, from: "include/types_types.hrl"
  deftype SharedNotebook, :SharedNotebook, from: "include/types_types.hrl"
  deftype SharedNotebookRecipientSettings, :SharedNotebookRecipientSettings, from: "include/types_types.hrl"
  deftype Tag, :Tag, from: "include/types_types.hrl"
  deftype User, :User, from: "include/types_types.hrl"
  deftype UserAttributes, :UserAttributes, from: "include/types_types.hrl"

  # NoteStore
  #
  deftype ClientUsageMetrics, :ClientUsageMetrics, from: "include/note_store_types.hrl"
  deftype NoteCollectionCounts, :NoteCollectionCounts, from: "include/note_store_types.hrl"
  deftype NoteEmailParameters, :NoteEmailParameters, from: "include/note_store_types.hrl"
  deftype NoteFilter, :NoteFilter, from: "include/note_store_types.hrl"
  deftype NoteList, :NoteList, from: "include/note_store_types.hrl"
  deftype NoteMetadata, :NoteMetadata, from: "include/note_store_types.hrl"
  deftype NotesMetadataList, :NotesMetadataList, from: "include/note_store_types.hrl"
  deftype NotesMetadataResultSpec, :NotesMetadataResultSpec, from: "include/note_store_types.hrl"
  deftype NoteVersionId, :NoteVersionId, from: "include/note_store_types.hrl"
  deftype RelatedQuery, :RelatedQuery, from: "include/note_store_types.hrl"
  deftype RelatedResult, :RelatedResult, from: "include/note_store_types.hrl"
  deftype RelatedResultSpec, :RelatedResultSpec, from: "include/note_store_types.hrl"
  deftype SyncChunk, :SyncChunk, from: "include/note_store_types.hrl"
  deftype SyncChunkFilter, :SyncChunkFilter, from: "include/note_store_types.hrl"
  deftype SyncState, :SyncState, from: "include/note_store_types.hrl"

  # UserStore
  #
  deftype AuthenticationResult, :AuthenticationResult, from: "include/user_store_types.hrl"
  deftype BootstrapInfo, :BootstrapInfo, from: "include/user_store_types.hrl"
  deftype BootstrapProfile, :BootstrapProfile, from: "include/user_store_types.hrl"
  deftype BootstrapSettings, :BootstrapSettings, from: "include/user_store_types.hrl"
  deftype PublicUserInfo, :PublicUserInfo, from: "include/user_store_types.hrl"

end
