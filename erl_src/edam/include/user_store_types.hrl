-ifndef(_user_store_types_included).
-define(_user_store_types_included, yeah).
-include("types_types.hrl").
-include("errors_types.hrl").


%% struct 'PublicUserInfo'

-record('PublicUserInfo', {'userId' :: integer(),
                           'shardId' :: string() | binary(),
                           'privilege' :: integer(),
                           'username' :: string() | binary(),
                           'noteStoreUrl' :: string() | binary(),
                           'webApiUrlPrefix' :: string() | binary()}).
-type 'PublicUserInfo'() :: #'PublicUserInfo'{}.

%% struct 'AuthenticationResult'

-record('AuthenticationResult', {'currentTime' :: integer(),
                                 'authenticationToken' :: string() | binary(),
                                 'expiration' :: integer(),
                                 'user' :: 'User'(),
                                 'publicUserInfo' :: 'PublicUserInfo'(),
                                 'noteStoreUrl' :: string() | binary(),
                                 'webApiUrlPrefix' :: string() | binary(),
                                 'secondFactorRequired' :: boolean(),
                                 'secondFactorDeliveryHint' :: string() | binary()}).
-type 'AuthenticationResult'() :: #'AuthenticationResult'{}.

%% struct 'BootstrapSettings'

-record('BootstrapSettings', {'serviceHost' :: string() | binary(),
                              'marketingUrl' :: string() | binary(),
                              'supportUrl' :: string() | binary(),
                              'accountEmailDomain' :: string() | binary(),
                              'enableFacebookSharing' :: boolean(),
                              'enableGiftSubscriptions' :: boolean(),
                              'enableSupportTickets' :: boolean(),
                              'enableSharedNotebooks' :: boolean(),
                              'enableSingleNoteSharing' :: boolean(),
                              'enableSponsoredAccounts' :: boolean(),
                              'enableTwitterSharing' :: boolean(),
                              'enableLinkedInSharing' :: boolean(),
                              'enablePublicNotebooks' :: boolean()}).
-type 'BootstrapSettings'() :: #'BootstrapSettings'{}.

%% struct 'BootstrapProfile'

-record('BootstrapProfile', {'name' :: string() | binary(),
                             'settings' = #'BootstrapSettings'{} :: 'BootstrapSettings'()}).
-type 'BootstrapProfile'() :: #'BootstrapProfile'{}.

%% struct 'BootstrapInfo'

-record('BootstrapInfo', {'profiles' = [] :: list()}).
-type 'BootstrapInfo'() :: #'BootstrapInfo'{}.

-endif.
