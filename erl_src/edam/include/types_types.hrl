-ifndef(_types_types_included).
-define(_types_types_included, yeah).
-include("limits_types.hrl").


-define(TYPES_PRIVILEGELEVEL_NORMAL, 1).
-define(TYPES_PRIVILEGELEVEL_PREMIUM, 3).
-define(TYPES_PRIVILEGELEVEL_VIP, 5).
-define(TYPES_PRIVILEGELEVEL_MANAGER, 7).
-define(TYPES_PRIVILEGELEVEL_SUPPORT, 8).
-define(TYPES_PRIVILEGELEVEL_ADMIN, 9).

-define(TYPES_QUERYFORMAT_USER, 1).
-define(TYPES_QUERYFORMAT_SEXP, 2).

-define(TYPES_NOTESORTORDER_CREATED, 1).
-define(TYPES_NOTESORTORDER_UPDATED, 2).
-define(TYPES_NOTESORTORDER_RELEVANCE, 3).
-define(TYPES_NOTESORTORDER_UPDATE_SEQUENCE_NUMBER, 4).
-define(TYPES_NOTESORTORDER_TITLE, 5).

-define(TYPES_PREMIUMORDERSTATUS_NONE, 0).
-define(TYPES_PREMIUMORDERSTATUS_PENDING, 1).
-define(TYPES_PREMIUMORDERSTATUS_ACTIVE, 2).
-define(TYPES_PREMIUMORDERSTATUS_FAILED, 3).
-define(TYPES_PREMIUMORDERSTATUS_CANCELLATION_PENDING, 4).
-define(TYPES_PREMIUMORDERSTATUS_CANCELED, 5).

-define(TYPES_SHAREDNOTEBOOKPRIVILEGELEVEL_READ_NOTEBOOK, 0).
-define(TYPES_SHAREDNOTEBOOKPRIVILEGELEVEL_MODIFY_NOTEBOOK_PLUS_ACTIVITY, 1).
-define(TYPES_SHAREDNOTEBOOKPRIVILEGELEVEL_READ_NOTEBOOK_PLUS_ACTIVITY, 2).
-define(TYPES_SHAREDNOTEBOOKPRIVILEGELEVEL_GROUP, 3).
-define(TYPES_SHAREDNOTEBOOKPRIVILEGELEVEL_FULL_ACCESS, 4).
-define(TYPES_SHAREDNOTEBOOKPRIVILEGELEVEL_BUSINESS_FULL_ACCESS, 5).

-define(TYPES_SPONSOREDGROUPROLE_GROUP_MEMBER, 1).
-define(TYPES_SPONSOREDGROUPROLE_GROUP_ADMIN, 2).
-define(TYPES_SPONSOREDGROUPROLE_GROUP_OWNER, 3).

-define(TYPES_BUSINESSUSERROLE_ADMIN, 1).
-define(TYPES_BUSINESSUSERROLE_NORMAL, 2).

-define(TYPES_SHAREDNOTEBOOKINSTANCERESTRICTIONS_ONLY_JOINED_OR_PREVIEW, 1).
-define(TYPES_SHAREDNOTEBOOKINSTANCERESTRICTIONS_NO_SHARED_NOTEBOOKS, 2).

-define(TYPES_REMINDEREMAILCONFIG_DO_NOT_SEND, 1).
-define(TYPES_REMINDEREMAILCONFIG_SEND_DAILY_EMAIL, 2).

%% struct 'Data'

-record('Data', {'bodyHash' :: string() | binary(),
                 'size' :: integer(),
                 'body' :: string() | binary()}).
-type 'Data'() :: #'Data'{}.

%% struct 'UserAttributes'

-record('UserAttributes', {'defaultLocationName' :: string() | binary(),
                           'defaultLatitude' :: float(),
                           'defaultLongitude' :: float(),
                           'preactivation' :: boolean(),
                           'viewedPromotions' :: list(),
                           'incomingEmailAddress' :: string() | binary(),
                           'recentMailedAddresses' :: list(),
                           'comments' :: string() | binary(),
                           'dateAgreedToTermsOfService' :: integer(),
                           'maxReferrals' :: integer(),
                           'referralCount' :: integer(),
                           'refererCode' :: string() | binary(),
                           'sentEmailDate' :: integer(),
                           'sentEmailCount' :: integer(),
                           'dailyEmailLimit' :: integer(),
                           'emailOptOutDate' :: integer(),
                           'partnerEmailOptInDate' :: integer(),
                           'preferredLanguage' :: string() | binary(),
                           'preferredCountry' :: string() | binary(),
                           'clipFullPage' :: boolean(),
                           'twitterUserName' :: string() | binary(),
                           'twitterId' :: string() | binary(),
                           'groupName' :: string() | binary(),
                           'recognitionLanguage' :: string() | binary(),
                           'referralProof' :: string() | binary(),
                           'educationalDiscount' :: boolean(),
                           'businessAddress' :: string() | binary(),
                           'hideSponsorBilling' :: boolean(),
                           'taxExempt' :: boolean(),
                           'useEmailAutoFiling' :: boolean(),
                           'reminderEmailConfig' :: integer()}).
-type 'UserAttributes'() :: #'UserAttributes'{}.

%% struct 'Accounting'

-record('Accounting', {'uploadLimit' :: integer(),
                       'uploadLimitEnd' :: integer(),
                       'uploadLimitNextMonth' :: integer(),
                       'premiumServiceStatus' :: integer(),
                       'premiumOrderNumber' :: string() | binary(),
                       'premiumCommerceService' :: string() | binary(),
                       'premiumServiceStart' :: integer(),
                       'premiumServiceSKU' :: string() | binary(),
                       'lastSuccessfulCharge' :: integer(),
                       'lastFailedCharge' :: integer(),
                       'lastFailedChargeReason' :: string() | binary(),
                       'nextPaymentDue' :: integer(),
                       'premiumLockUntil' :: integer(),
                       'updated' :: integer(),
                       'premiumSubscriptionNumber' :: string() | binary(),
                       'lastRequestedCharge' :: integer(),
                       'currency' :: string() | binary(),
                       'unitPrice' :: integer(),
                       'businessId' :: integer(),
                       'businessName' :: string() | binary(),
                       'businessRole' :: integer(),
                       'unitDiscount' :: integer(),
                       'nextChargeDate' :: integer()}).
-type 'Accounting'() :: #'Accounting'{}.

%% struct 'BusinessUserInfo'

-record('BusinessUserInfo', {'businessId' :: integer(),
                             'businessName' :: string() | binary(),
                             'role' :: integer(),
                             'email' :: string() | binary()}).
-type 'BusinessUserInfo'() :: #'BusinessUserInfo'{}.

%% struct 'PremiumInfo'

-record('PremiumInfo', {'currentTime' :: integer(),
                        'premium' :: boolean(),
                        'premiumRecurring' :: boolean(),
                        'premiumExpirationDate' :: integer(),
                        'premiumExtendable' :: boolean(),
                        'premiumPending' :: boolean(),
                        'premiumCancellationPending' :: boolean(),
                        'canPurchaseUploadAllowance' :: boolean(),
                        'sponsoredGroupName' :: string() | binary(),
                        'sponsoredGroupRole' :: integer(),
                        'premiumUpgradable' :: boolean()}).
-type 'PremiumInfo'() :: #'PremiumInfo'{}.

%% struct 'User'

-record('User', {'id' :: integer(),
                 'username' :: string() | binary(),
                 'email' :: string() | binary(),
                 'name' :: string() | binary(),
                 'timezone' :: string() | binary(),
                 'privilege' :: integer(),
                 'created' :: integer(),
                 'updated' :: integer(),
                 'deleted' :: integer(),
                 'active' :: boolean(),
                 'shardId' :: string() | binary(),
                 'attributes' :: 'UserAttributes'(),
                 'accounting' :: 'Accounting'(),
                 'premiumInfo' :: 'PremiumInfo'(),
                 'businessUserInfo' :: 'BusinessUserInfo'()}).
-type 'User'() :: #'User'{}.

%% struct 'Tag'

-record('Tag', {'guid' :: string() | binary(),
                'name' :: string() | binary(),
                'parentGuid' :: string() | binary(),
                'updateSequenceNum' :: integer()}).
-type 'Tag'() :: #'Tag'{}.

%% struct 'LazyMap'

-record('LazyMap', {'keysOnly' :: set(),
                    'fullMap' :: dict()}).
-type 'LazyMap'() :: #'LazyMap'{}.

%% struct 'ResourceAttributes'

-record('ResourceAttributes', {'sourceURL' :: string() | binary(),
                               'timestamp' :: integer(),
                               'latitude' :: float(),
                               'longitude' :: float(),
                               'altitude' :: float(),
                               'cameraMake' :: string() | binary(),
                               'cameraModel' :: string() | binary(),
                               'clientWillIndex' :: boolean(),
                               'recoType' :: string() | binary(),
                               'fileName' :: string() | binary(),
                               'attachment' :: boolean(),
                               'applicationData' :: 'LazyMap'()}).
-type 'ResourceAttributes'() :: #'ResourceAttributes'{}.

%% struct 'Resource'

-record('Resource', {'guid' :: string() | binary(),
                     'noteGuid' :: string() | binary(),
                     'data' :: 'Data'(),
                     'mime' :: string() | binary(),
                     'width' :: integer(),
                     'height' :: integer(),
                     'duration' :: integer(),
                     'active' :: boolean(),
                     'recognition' :: 'Data'(),
                     'attributes' :: 'ResourceAttributes'(),
                     'updateSequenceNum' :: integer(),
                     'alternateData' :: 'Data'()}).
-type 'Resource'() :: #'Resource'{}.

%% struct 'NoteAttributes'

-record('NoteAttributes', {'subjectDate' :: integer(),
                           'latitude' :: float(),
                           'longitude' :: float(),
                           'altitude' :: float(),
                           'author' :: string() | binary(),
                           'source' :: string() | binary(),
                           'sourceURL' :: string() | binary(),
                           'sourceApplication' :: string() | binary(),
                           'shareDate' :: integer(),
                           'reminderOrder' :: integer(),
                           'reminderDoneTime' :: integer(),
                           'reminderTime' :: integer(),
                           'placeName' :: string() | binary(),
                           'contentClass' :: string() | binary(),
                           'applicationData' :: 'LazyMap'(),
                           'lastEditedBy' :: string() | binary(),
                           'classifications' :: dict(),
                           'creatorId' :: integer(),
                           'lastEditorId' :: integer()}).
-type 'NoteAttributes'() :: #'NoteAttributes'{}.

%% struct 'Note'

-record('Note', {'guid' :: string() | binary(),
                 'title' :: string() | binary(),
                 'content' :: string() | binary(),
                 'contentHash' :: string() | binary(),
                 'contentLength' :: integer(),
                 'created' :: integer(),
                 'updated' :: integer(),
                 'deleted' :: integer(),
                 'active' :: boolean(),
                 'updateSequenceNum' :: integer(),
                 'notebookGuid' :: string() | binary(),
                 'tagGuids' :: list(),
                 'resources' :: list(),
                 'attributes' :: 'NoteAttributes'(),
                 'tagNames' :: list()}).
-type 'Note'() :: #'Note'{}.

%% struct 'Publishing'

-record('Publishing', {'uri' :: string() | binary(),
                       'order' :: integer(),
                       'ascending' :: boolean(),
                       'publicDescription' :: string() | binary()}).
-type 'Publishing'() :: #'Publishing'{}.

%% struct 'BusinessNotebook'

-record('BusinessNotebook', {'notebookDescription' :: string() | binary(),
                             'privilege' :: integer(),
                             'recommended' :: boolean()}).
-type 'BusinessNotebook'() :: #'BusinessNotebook'{}.

%% struct 'SavedSearchScope'

-record('SavedSearchScope', {'includeAccount' :: boolean(),
                             'includePersonalLinkedNotebooks' :: boolean(),
                             'includeBusinessLinkedNotebooks' :: boolean()}).
-type 'SavedSearchScope'() :: #'SavedSearchScope'{}.

%% struct 'SavedSearch'

-record('SavedSearch', {'guid' :: string() | binary(),
                        'name' :: string() | binary(),
                        'query' :: string() | binary(),
                        'format' :: integer(),
                        'updateSequenceNum' :: integer(),
                        'scope' :: 'SavedSearchScope'()}).
-type 'SavedSearch'() :: #'SavedSearch'{}.

%% struct 'SharedNotebookRecipientSettings'

-record('SharedNotebookRecipientSettings', {'reminderNotifyEmail' :: boolean(),
                                            'reminderNotifyInApp' :: boolean()}).
-type 'SharedNotebookRecipientSettings'() :: #'SharedNotebookRecipientSettings'{}.

%% struct 'SharedNotebook'

-record('SharedNotebook', {'id' :: integer(),
                           'userId' :: integer(),
                           'notebookGuid' :: string() | binary(),
                           'email' :: string() | binary(),
                           'notebookModifiable' :: boolean(),
                           'requireLogin' :: boolean(),
                           'serviceCreated' :: integer(),
                           'serviceUpdated' :: integer(),
                           'shareKey' :: string() | binary(),
                           'username' :: string() | binary(),
                           'privilege' :: integer(),
                           'allowPreview' :: boolean(),
                           'recipientSettings' :: 'SharedNotebookRecipientSettings'()}).
-type 'SharedNotebook'() :: #'SharedNotebook'{}.

%% struct 'NotebookRestrictions'

-record('NotebookRestrictions', {'noReadNotes' :: boolean(),
                                 'noCreateNotes' :: boolean(),
                                 'noUpdateNotes' :: boolean(),
                                 'noExpungeNotes' :: boolean(),
                                 'noShareNotes' :: boolean(),
                                 'noEmailNotes' :: boolean(),
                                 'noSendMessageToRecipients' :: boolean(),
                                 'noUpdateNotebook' :: boolean(),
                                 'noExpungeNotebook' :: boolean(),
                                 'noSetDefaultNotebook' :: boolean(),
                                 'noSetNotebookStack' :: boolean(),
                                 'noPublishToPublic' :: boolean(),
                                 'noPublishToBusinessLibrary' :: boolean(),
                                 'noCreateTags' :: boolean(),
                                 'noUpdateTags' :: boolean(),
                                 'noExpungeTags' :: boolean(),
                                 'noSetParentTag' :: boolean(),
                                 'noCreateSharedNotebooks' :: boolean(),
                                 'updateWhichSharedNotebookRestrictions' :: integer(),
                                 'expungeWhichSharedNotebookRestrictions' :: integer()}).
-type 'NotebookRestrictions'() :: #'NotebookRestrictions'{}.

%% struct 'Notebook'

-record('Notebook', {'guid' :: string() | binary(),
                     'name' :: string() | binary(),
                     'updateSequenceNum' :: integer(),
                     'defaultNotebook' :: boolean(),
                     'serviceCreated' :: integer(),
                     'serviceUpdated' :: integer(),
                     'publishing' :: 'Publishing'(),
                     'published' :: boolean(),
                     'stack' :: string() | binary(),
                     'sharedNotebookIds' :: list(),
                     'sharedNotebooks' :: list(),
                     'businessNotebook' :: 'BusinessNotebook'(),
                     'contact' :: 'User'(),
                     'restrictions' :: 'NotebookRestrictions'()}).
-type 'Notebook'() :: #'Notebook'{}.

%% struct 'LinkedNotebook'

-record('LinkedNotebook', {'shareName' :: string() | binary(),
                           'username' :: string() | binary(),
                           'shardId' :: string() | binary(),
                           'shareKey' :: string() | binary(),
                           'uri' :: string() | binary(),
                           'guid' :: string() | binary(),
                           'updateSequenceNum' :: integer(),
                           'noteStoreUrl' :: string() | binary(),
                           'webApiUrlPrefix' :: string() | binary(),
                           'stack' :: string() | binary(),
                           'businessId' :: integer()}).
-type 'LinkedNotebook'() :: #'LinkedNotebook'{}.

%% struct 'NotebookDescriptor'

-record('NotebookDescriptor', {'guid' :: string() | binary(),
                               'notebookDisplayName' :: string() | binary(),
                               'contactName' :: string() | binary(),
                               'hasSharedNotebook' :: boolean(),
                               'joinedUserCount' :: integer()}).
-type 'NotebookDescriptor'() :: #'NotebookDescriptor'{}.

-endif.
