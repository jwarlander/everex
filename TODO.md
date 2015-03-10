ToDo
====

-   Include OAuth helpers in main lib; look at other EN APIs for examples
-   Documentation on personal use with Developer Tokens for sandbox + prod
-   Handle the `errorCode` field of exceptions; see ERRORS_EDAMERRORCODE_*
    in errors_types.hrl.. can we give something better than just the number?
-   Investigate "bad return value" exit from GenServer on Thrift exception;
    try `Everex.NoteStore.get_note(client, "f00f00")`
-   Clean up and consolidate record <-> struct conversion
-   Create macro for defining Thrift calls?
-   Consider arg passing conventions; use keyword lists? If so, how to handle
    defaults?
-   Test nested struct / record conversion, as well as in lists
-   Mock the Thrift calls for unit testing
-   Add separate integration tests?
-   Add calls to get / set application data on notes
-   Bang (!) equivalents for most actions, that will return just the response
    instead of {:ok, <response>}, and raise exceptions on errors
-   Set up at least basic logging
