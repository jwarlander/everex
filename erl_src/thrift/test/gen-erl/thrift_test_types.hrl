-ifndef(_thrift_test_types_included).
-define(_thrift_test_types_included, yeah).

-define(THRIFT_TEST_NUMBERZ_ONE, 1).
-define(THRIFT_TEST_NUMBERZ_TWO, 2).
-define(THRIFT_TEST_NUMBERZ_THREE, 3).
-define(THRIFT_TEST_NUMBERZ_FIVE, 5).
-define(THRIFT_TEST_NUMBERZ_SIX, 6).
-define(THRIFT_TEST_NUMBERZ_EIGHT, 8).

%% struct 'Bonk'

-record('Bonk', {'message' :: string() | binary(),
                 'type' :: integer()}).
-type 'Bonk'() :: #'Bonk'{}.

%% struct 'Bools'

-record('Bools', {'im_true' :: boolean(),
                  'im_false' :: boolean()}).
-type 'Bools'() :: #'Bools'{}.

%% struct 'Xtruct'

-record('Xtruct', {'string_thing' :: string() | binary(),
                   'byte_thing' :: integer(),
                   'i32_thing' :: integer(),
                   'i64_thing' :: integer()}).
-type 'Xtruct'() :: #'Xtruct'{}.

%% struct 'Xtruct2'

-record('Xtruct2', {'byte_thing' :: integer(),
                    'struct_thing' :: 'Xtruct'(),
                    'i32_thing' :: integer()}).
-type 'Xtruct2'() :: #'Xtruct2'{}.

%% struct 'Xtruct3'

-record('Xtruct3', {'string_thing' :: string() | binary(),
                    'changed' :: integer(),
                    'i32_thing' :: integer(),
                    'i64_thing' :: integer()}).
-type 'Xtruct3'() :: #'Xtruct3'{}.

%% struct 'Insanity'

-record('Insanity', {'userMap' :: dict(),
                     'xtructs' :: list()}).
-type 'Insanity'() :: #'Insanity'{}.

%% struct 'CrazyNesting'

-record('CrazyNesting', {'string_field' :: string() | binary(),
                         'set_field' :: set(),
                         'list_field' = [] :: list(),
                         'binary_field' :: string() | binary()}).
-type 'CrazyNesting'() :: #'CrazyNesting'{}.

%% struct 'Xception'

-record('Xception', {'errorCode' :: integer(),
                     'message' :: string() | binary()}).
-type 'Xception'() :: #'Xception'{}.

%% struct 'Xception2'

-record('Xception2', {'errorCode' :: integer(),
                      'struct_thing' :: 'Xtruct'()}).
-type 'Xception2'() :: #'Xception2'{}.

%% struct 'EmptyStruct'

-record('EmptyStruct', {}).
-type 'EmptyStruct'() :: #'EmptyStruct'{}.

%% struct 'OneField'

-record('OneField', {'field' :: 'EmptyStruct'()}).
-type 'OneField'() :: #'OneField'{}.

%% struct 'VersioningTestV1'

-record('VersioningTestV1', {'begin_in_both' :: integer(),
                             'old_string' :: string() | binary(),
                             'end_in_both' :: integer()}).
-type 'VersioningTestV1'() :: #'VersioningTestV1'{}.

%% struct 'VersioningTestV2'

-record('VersioningTestV2', {'begin_in_both' :: integer(),
                             'newint' :: integer(),
                             'newbyte' :: integer(),
                             'newshort' :: integer(),
                             'newlong' :: integer(),
                             'newdouble' :: float(),
                             'newstruct' :: 'Bonk'(),
                             'newlist' :: list(),
                             'newset' :: set(),
                             'newmap' :: dict(),
                             'newstring' :: string() | binary(),
                             'end_in_both' :: integer()}).
-type 'VersioningTestV2'() :: #'VersioningTestV2'{}.

%% struct 'ListTypeVersioningV1'

-record('ListTypeVersioningV1', {'myints' :: list(),
                                 'hello' :: string() | binary()}).
-type 'ListTypeVersioningV1'() :: #'ListTypeVersioningV1'{}.

%% struct 'ListTypeVersioningV2'

-record('ListTypeVersioningV2', {'strings' :: list(),
                                 'hello' :: string() | binary()}).
-type 'ListTypeVersioningV2'() :: #'ListTypeVersioningV2'{}.

%% struct 'GuessProtocolStruct'

-record('GuessProtocolStruct', {'map_field' :: dict()}).
-type 'GuessProtocolStruct'() :: #'GuessProtocolStruct'{}.

%% struct 'LargeDeltas'

-record('LargeDeltas', {'b1' :: 'Bools'(),
                        'b10' :: 'Bools'(),
                        'b100' :: 'Bools'(),
                        'check_true' :: boolean(),
                        'b1000' :: 'Bools'(),
                        'check_false' :: boolean(),
                        'vertwo2000' :: 'VersioningTestV2'(),
                        'a_set2500' :: set(),
                        'vertwo3000' :: 'VersioningTestV2'(),
                        'big_numbers' :: list()}).
-type 'LargeDeltas'() :: #'LargeDeltas'{}.

%% struct 'NestedListsI32x2'

-record('NestedListsI32x2', {'integerlist' :: list()}).
-type 'NestedListsI32x2'() :: #'NestedListsI32x2'{}.

%% struct 'NestedListsI32x3'

-record('NestedListsI32x3', {'integerlist' :: list()}).
-type 'NestedListsI32x3'() :: #'NestedListsI32x3'{}.

%% struct 'NestedMixedx2'

-record('NestedMixedx2', {'int_set_list' :: list(),
                          'map_int_strset' :: dict(),
                          'map_int_strset_list' :: list()}).
-type 'NestedMixedx2'() :: #'NestedMixedx2'{}.

%% struct 'ListBonks'

-record('ListBonks', {'bonk' :: list()}).
-type 'ListBonks'() :: #'ListBonks'{}.

%% struct 'NestedListsBonk'

-record('NestedListsBonk', {'bonk' :: list()}).
-type 'NestedListsBonk'() :: #'NestedListsBonk'{}.

%% struct 'BoolTest'

-record('BoolTest', {'b' = true :: boolean(),
                     's' = "true" :: string() | binary()}).
-type 'BoolTest'() :: #'BoolTest'{}.

%% struct 'StructA'

-record('StructA', {'s' :: string() | binary()}).
-type 'StructA'() :: #'StructA'{}.

%% struct 'StructB'

-record('StructB', {'aa' :: 'StructA'(),
                    'ab' = #'StructA'{} :: 'StructA'()}).
-type 'StructB'() :: #'StructB'{}.

-endif.
