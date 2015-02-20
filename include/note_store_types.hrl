-ifndef(_note_store_types_included).
-define(_note_store_types_included, yeah).
-include("user_store_types.hrl").
-include("types_types.hrl").
-include("errors_types.hrl").
-include("limits_types.hrl").


%% struct 'SyncState'

-record('SyncState', {'currentTime' :: integer(),
                      'fullSyncBefore' :: integer(),
                      'updateCount' :: integer(),
                      'uploaded' :: integer()}).
-type 'SyncState'() :: #'SyncState'{}.

%% struct 'SyncChunk'

-record('SyncChunk', {'currentTime' :: integer(),
                      'chunkHighUSN' :: integer(),
                      'updateCount' :: integer(),
                      'notes' :: list(),
                      'notebooks' :: list(),
                      'tags' :: list(),
                      'searches' :: list(),
                      'resources' :: list(),
                      'expungedNotes' :: list(),
                      'expungedNotebooks' :: list(),
                      'expungedTags' :: list(),
                      'expungedSearches' :: list(),
                      'linkedNotebooks' :: list(),
                      'expungedLinkedNotebooks' :: list()}).
-type 'SyncChunk'() :: #'SyncChunk'{}.

%% struct 'SyncChunkFilter'

-record('SyncChunkFilter', {'includeNotes' :: boolean(),
                            'includeNoteResources' :: boolean(),
                            'includeNoteAttributes' :: boolean(),
                            'includeNotebooks' :: boolean(),
                            'includeTags' :: boolean(),
                            'includeSearches' :: boolean(),
                            'includeResources' :: boolean(),
                            'includeLinkedNotebooks' :: boolean(),
                            'includeExpunged' :: boolean(),
                            'includeNoteApplicationDataFullMap' :: boolean(),
                            'includeResourceApplicationDataFullMap' :: boolean(),
                            'includeNoteResourceApplicationDataFullMap' :: boolean(),
                            'requireNoteContentClass' :: string() | binary()}).
-type 'SyncChunkFilter'() :: #'SyncChunkFilter'{}.

%% struct 'NoteFilter'

-record('NoteFilter', {'order' :: integer(),
                       'ascending' :: boolean(),
                       'words' :: string() | binary(),
                       'notebookGuid' :: string() | binary(),
                       'tagGuids' :: list(),
                       'timeZone' :: string() | binary(),
                       'inactive' :: boolean(),
                       'emphasized' :: string() | binary()}).
-type 'NoteFilter'() :: #'NoteFilter'{}.

%% struct 'NoteList'

-record('NoteList', {'startIndex' :: integer(),
                     'totalNotes' :: integer(),
                     'notes' = [] :: list(),
                     'stoppedWords' :: list(),
                     'searchedWords' :: list(),
                     'updateCount' :: integer()}).
-type 'NoteList'() :: #'NoteList'{}.

%% struct 'NoteMetadata'

-record('NoteMetadata', {'guid' :: string() | binary(),
                         'title' :: string() | binary(),
                         'contentLength' :: integer(),
                         'created' :: integer(),
                         'updated' :: integer(),
                         'deleted' :: integer(),
                         'updateSequenceNum' :: integer(),
                         'notebookGuid' :: string() | binary(),
                         'tagGuids' :: list(),
                         'attributes' :: 'NoteAttributes'(),
                         'largestResourceMime' :: string() | binary(),
                         'largestResourceSize' :: integer()}).
-type 'NoteMetadata'() :: #'NoteMetadata'{}.

%% struct 'NotesMetadataList'

-record('NotesMetadataList', {'startIndex' :: integer(),
                              'totalNotes' :: integer(),
                              'notes' = [] :: list(),
                              'stoppedWords' :: list(),
                              'searchedWords' :: list(),
                              'updateCount' :: integer()}).
-type 'NotesMetadataList'() :: #'NotesMetadataList'{}.

%% struct 'NotesMetadataResultSpec'

-record('NotesMetadataResultSpec', {'includeTitle' :: boolean(),
                                    'includeContentLength' :: boolean(),
                                    'includeCreated' :: boolean(),
                                    'includeUpdated' :: boolean(),
                                    'includeDeleted' :: boolean(),
                                    'includeUpdateSequenceNum' :: boolean(),
                                    'includeNotebookGuid' :: boolean(),
                                    'includeTagGuids' :: boolean(),
                                    'includeAttributes' :: boolean(),
                                    'includeLargestResourceMime' :: boolean(),
                                    'includeLargestResourceSize' :: boolean()}).
-type 'NotesMetadataResultSpec'() :: #'NotesMetadataResultSpec'{}.

%% struct 'NoteCollectionCounts'

-record('NoteCollectionCounts', {'notebookCounts' :: dict(),
                                 'tagCounts' :: dict(),
                                 'trashCount' :: integer()}).
-type 'NoteCollectionCounts'() :: #'NoteCollectionCounts'{}.

%% struct 'NoteEmailParameters'

-record('NoteEmailParameters', {'guid' :: string() | binary(),
                                'note' :: 'Note'(),
                                'toAddresses' :: list(),
                                'ccAddresses' :: list(),
                                'subject' :: string() | binary(),
                                'message' :: string() | binary()}).
-type 'NoteEmailParameters'() :: #'NoteEmailParameters'{}.

%% struct 'NoteVersionId'

-record('NoteVersionId', {'updateSequenceNum' :: integer(),
                          'updated' :: integer(),
                          'saved' :: integer(),
                          'title' :: string() | binary()}).
-type 'NoteVersionId'() :: #'NoteVersionId'{}.

%% struct 'ClientUsageMetrics'

-record('ClientUsageMetrics', {'sessions' :: integer()}).
-type 'ClientUsageMetrics'() :: #'ClientUsageMetrics'{}.

%% struct 'RelatedQuery'

-record('RelatedQuery', {'noteGuid' :: string() | binary(),
                         'plainText' :: string() | binary(),
                         'filter' :: 'NoteFilter'(),
                         'referenceUri' :: string() | binary()}).
-type 'RelatedQuery'() :: #'RelatedQuery'{}.

%% struct 'RelatedResult'

-record('RelatedResult', {'notes' :: list(),
                          'notebooks' :: list(),
                          'tags' :: list(),
                          'containingNotebooks' :: list()}).
-type 'RelatedResult'() :: #'RelatedResult'{}.

%% struct 'RelatedResultSpec'

-record('RelatedResultSpec', {'maxNotes' :: integer(),
                              'maxNotebooks' :: integer(),
                              'maxTags' :: integer(),
                              'writableNotebooksOnly' :: boolean(),
                              'includeContainingNotebooks' :: boolean()}).
-type 'RelatedResultSpec'() :: #'RelatedResultSpec'{}.

-endif.
