ToDo
====

-   Make struct_to_record() handle embedded structs, direcly and in lists
-   Do something useful when auth_token is missing in Client.new()
-   Mock the Thrift calls for unit testing
-   Add separate integration tests?
-   Add calls to get / set application data on notes
-   Bang (!) equivalents for most actions, that will return just the response
    instead of {:ok, <response>}, and raise exceptions on errors
-   Set up at least basic logging
-   Consider wrapping EDAM results in maps
