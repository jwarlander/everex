-ifndef(_thrift1151_types_included).
-define(_thrift1151_types_included, yeah).

%% struct 'StructA'

-record('StructA', {'x' :: integer()}).
-type 'StructA'() :: #'StructA'{}.

%% struct 'StructB'

-record('StructB', {'x' :: integer()}).
-type 'StructB'() :: #'StructB'{}.

%% struct 'StructC'

-record('StructC', {'x' :: 'StructA'()}).
-type 'StructC'() :: #'StructC'{}.

-endif.
