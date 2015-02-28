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

defmodule Everex.Types do
  use Everex.Util

  defmacro __using__(_options) do
    quote do
      alias Everex.Types
      require Types.Note
    end
  end

  # Common Types
  #
  deftype Accounting, :Accounting,
    Record.extract(:Accounting, from: "include/types_types.hrl")
  deftype BusinessNotebook, :BusinessNotebook,
    Record.extract(:BusinessNotebook, from: "include/types_types.hrl")
  deftype BusinessUserInfo, :BusinessUserInfo,
    Record.extract(:BusinessUserInfo, from: "include/types_types.hrl")
  deftype Data, :Data,
    Record.extract(:Data, from: "include/types_types.hrl")
  deftype LazyMap, :LazyMap,
    Record.extract(:LazyMap, from: "include/types_types.hrl")
  deftype LinkedNotebook, :LinkedNotebook,
    Record.extract(:LinkedNotebook, from: "include/types_types.hrl")
  deftype Note, :Note,
    Record.extract(:Note, from: "include/types_types.hrl")
  deftype NoteAttributes, :NoteAttributes,
    Record.extract(:NoteAttributes, from: "include/types_types.hrl")
  deftype Notebook, :Notebook,
    Record.extract(:Notebook, from: "include/types_types.hrl")
  deftype NotebookDescriptor, :NotebookDescriptor,
    Record.extract(:NotebookDescriptor, from: "include/types_types.hrl")
  deftype NotebookRestrictions, :NotebookRestrictions,
    Record.extract(:NotebookRestrictions, from: "include/types_types.hrl")
  deftype PremiumInfo, :PremiumInfo,
    Record.extract(:PremiumInfo, from: "include/types_types.hrl")
  deftype Publishing, :Publishing,
    Record.extract(:Publishing, from: "include/types_types.hrl")
  deftype Resource, :Resource,
    Record.extract(:Resource, from: "include/types_types.hrl")
  deftype ResourceAttributes, :ResourceAttributes,
    Record.extract(:ResourceAttributes, from: "include/types_types.hrl")
  deftype SavedSearch, :SavedSearch,
    Record.extract(:SavedSearch, from: "include/types_types.hrl")
  deftype SavedSearchScope, :SavedSearchScope,
    Record.extract(:SavedSearchScope, from: "include/types_types.hrl")
  deftype SharedNotebook, :SharedNotebook,
    Record.extract(:SharedNotebook, from: "include/types_types.hrl")
  deftype SharedNotebookRecipientSettings, :SharedNotebookRecipientSettings,
    Record.extract(:SharedNotebookRecipientSettings, from: "include/types_types.hrl")
  deftype Tag, :Tag,
    Record.extract(:Tag, from: "include/types_types.hrl")
  deftype User, :User,
    Record.extract(:User, from: "include/types_types.hrl")
  deftype UserAttributes, :UserAttributes,
    Record.extract(:UserAttributes, from: "include/types_types.hrl")

  # NoteStore
  #
  deftype ClientUsageMetrics, :ClientUsageMetrics,
    Record.extract(:ClientUsageMetrics, from: "include/note_store_types.hrl")
  deftype NoteCollectionCounts, :NoteCollectionCounts,
    Record.extract(:NoteCollectionCounts, from: "include/note_store_types.hrl")
  deftype NoteEmailParameters, :NoteEmailParameters,
    Record.extract(:NoteEmailParameters, from: "include/note_store_types.hrl")
  deftype NoteFilter, :NoteFilter,
    Record.extract(:NoteFilter, from: "include/note_store_types.hrl")
  deftype NoteList, :NoteList,
    Record.extract(:NoteList, from: "include/note_store_types.hrl")
  deftype NoteMetadata, :NoteMetadata,
    Record.extract(:NoteMetadata, from: "include/note_store_types.hrl")
  deftype NotesMetadataList, :NotesMetadataList,
    Record.extract(:NotesMetadataList, from: "include/note_store_types.hrl")
  deftype NotesMetadataResultSpec, :NotesMetadataResultSpec,
    Record.extract(:NotesMetadataResultSpec, from: "include/note_store_types.hrl")
  deftype NoteVersionId, :NoteVersionId,
    Record.extract(:NoteVersionId, from: "include/note_store_types.hrl")
  deftype RelatedQuery, :RelatedQuery,
    Record.extract(:RelatedQuery, from: "include/note_store_types.hrl")
  deftype RelatedResult, :RelatedResult,
    Record.extract(:RelatedResult, from: "include/note_store_types.hrl")
  deftype RelatedResultSpec, :RelatedResultSpec,
    Record.extract(:RelatedResultSpec, from: "include/note_store_types.hrl")
  deftype SyncChunk, :SyncChunk,
    Record.extract(:SyncChunk, from: "include/note_store_types.hrl")
  deftype SyncChunkFilter, :SyncChunkFilter,
    Record.extract(:SyncChunkFilter, from: "include/note_store_types.hrl")
  deftype SyncState, :SyncState,
    Record.extract(:SyncState, from: "include/note_store_types.hrl")

  # UserStore
  #
  deftype AuthenticationResult, :AuthenticationResult,
    Record.extract(:AuthenticationResult, from: "include/user_store_types.hrl")
  deftype BootstrapInfo, :BootstrapInfo,
    Record.extract(:BootstrapInfo, from: "include/user_store_types.hrl")
  deftype BootstrapProfile, :BootstrapProfile,
    Record.extract(:BootstrapProfile, from: "include/user_store_types.hrl")
  deftype BootstrapSettings, :BootstrapSettings,
    Record.extract(:BootstrapSettings, from: "include/user_store_types.hrl")
  deftype PublicUserInfo, :PublicUserInfo,
    Record.extract(:PublicUserInfo, from: "include/user_store_types.hrl")

end
