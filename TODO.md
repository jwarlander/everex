ToDo
====

-   Add documentation & push to Hex
-   Clean up and consolidate record <-> struct conversion
-   Create macro for defining Thrift calls?
-   Consider arg passing conventions; use keyword lists? If so, how to handle
    defaults?
-   Test nested struct / record conversion, as well as in lists
-   Do something useful when auth_token is missing in Client.new()
-   Mock the Thrift calls for unit testing
-   Add separate integration tests?
-   Add calls to get / set application data on notes
-   Bang (!) equivalents for most actions, that will return just the response
    instead of {:ok, <response>}, and raise exceptions on errors
-   Set up at least basic logging
