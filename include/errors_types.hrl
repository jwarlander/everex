-ifndef(_errors_types_included).
-define(_errors_types_included, yeah).

-define(ERRORS_EDAMERRORCODE_UNKNOWN, 1).
-define(ERRORS_EDAMERRORCODE_BAD_DATA_FORMAT, 2).
-define(ERRORS_EDAMERRORCODE_PERMISSION_DENIED, 3).
-define(ERRORS_EDAMERRORCODE_INTERNAL_ERROR, 4).
-define(ERRORS_EDAMERRORCODE_DATA_REQUIRED, 5).
-define(ERRORS_EDAMERRORCODE_LIMIT_REACHED, 6).
-define(ERRORS_EDAMERRORCODE_QUOTA_REACHED, 7).
-define(ERRORS_EDAMERRORCODE_INVALID_AUTH, 8).
-define(ERRORS_EDAMERRORCODE_AUTH_EXPIRED, 9).
-define(ERRORS_EDAMERRORCODE_DATA_CONFLICT, 10).
-define(ERRORS_EDAMERRORCODE_ENML_VALIDATION, 11).
-define(ERRORS_EDAMERRORCODE_SHARD_UNAVAILABLE, 12).
-define(ERRORS_EDAMERRORCODE_LEN_TOO_SHORT, 13).
-define(ERRORS_EDAMERRORCODE_LEN_TOO_LONG, 14).
-define(ERRORS_EDAMERRORCODE_TOO_FEW, 15).
-define(ERRORS_EDAMERRORCODE_TOO_MANY, 16).
-define(ERRORS_EDAMERRORCODE_UNSUPPORTED_OPERATION, 17).
-define(ERRORS_EDAMERRORCODE_TAKEN_DOWN, 18).
-define(ERRORS_EDAMERRORCODE_RATE_LIMIT_REACHED, 19).

%% struct 'EDAMUserException'

-record('EDAMUserException', {'errorCode' :: integer(),
                              'parameter' :: string() | binary()}).
-type 'EDAMUserException'() :: #'EDAMUserException'{}.

%% struct 'EDAMSystemException'

-record('EDAMSystemException', {'errorCode' :: integer(),
                                'message' :: string() | binary(),
                                'rateLimitDuration' :: integer()}).
-type 'EDAMSystemException'() :: #'EDAMSystemException'{}.

%% struct 'EDAMNotFoundException'

-record('EDAMNotFoundException', {'identifier' :: string() | binary(),
                                  'key' :: string() | binary()}).
-type 'EDAMNotFoundException'() :: #'EDAMNotFoundException'{}.

-endif.
