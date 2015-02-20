Everex
======

Evernote API client for Elixir. Uses a modified version of the
[Erlang Thrift library](https://github.com/apache/thrift/tree/master/lib/erl),
together with compiled output from the
[Evernote Cloud API IDL files](https://github.com/evernote/evernote-thrift).

_**NOTE:** Everex is UNDER DEVELOPMENT, and is NOT ready for production use.
Feedback and contributions (via pull requests) are very welcome, of course!_

Status
------

It's so far possible to list tags, list notebooks, find notes, and retrieve
note data.

An authentication token is required before connecting, and can be either a
user token retrieved
[using OAuth](https://dev.evernote.com/doc/articles/authentication.php)
or a [developer token](https://sandbox.evernote.com/api/DeveloperToken.action).

_Everex doesn't help at all with the OAuth process for getting access to
accounts; you'll have to solve that yourself, for the time being, and then
just supply the authentication token when creating the client connection._

Usage
-----

Add Everex to your dependencies in `mix.exs`:

```elixir
  defp deps do
    [{:everex, "~> 0.0.1"}]
  end
```

You also need to include `:everex` in your application list:

```elixir
  def application do
    [applications: [:everex]]
  end

```

Examples
--------

_**NOTE:** It's assumed that you're testing in the Evernote Sandbox, with a
developer token._

    iex(1)> require Everex.NoteStore      
    nil
    iex(2)> {:ok, client} = Everex.Client.new(System.get_env("EN_DEVELOPER_TOKEN"), sandbox: true)
    {:ok, #PID<0.262.0>}
    iex(3)> client |> Everex.NoteStore.list_tags
    {:ok,
     [{:Tag, "98590060-4eaa-44fe-8514-50cb158742c2", "one_tag", :undefined, 20},
      {:Tag, "f8484cd9-f213-4072-9df5-c0ab49f79fe3", "another_tag", :undefined,
       22}]}
    iex(4)> tag_filter = Everex.NoteStore.note_filter(tagGuids: ["98590060-4eaa-44fe-8514-50cb158742c2"])
    {:NoteFilter, :undefined, :undefined, :undefined, :undefined,
     ["98590060-4eaa-44fe-8514-50cb158742c2"], :undefined, :undefined, :undefined}
    iex(5)> client |> Everex.NoteStore.find_notes_metadata(tag_filter)
    {:ok,
     {:NotesMetadataList, 0, 1,
      [{:NoteMetadata, "9a6cbc15-613c-4e77-b184-76829421c3db", :undefined,
        :undefined, :undefined, :undefined, :undefined, :undefined, :undefined,
        :undefined, :undefined, :undefined, :undefined}], :undefined, :undefined,
      22}}
    iex(6)> client |> Everex.NoteStore.get_note("9a6cbc15-613c-4e77-b184-76829421c3db",true)
    {:ok,
     {:Note, "9a6cbc15-613c-4e77-b184-76829421c3db", "Another test, to be sure",
      "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">\n<en-note><div>We'll tag these, too!<br clear=\"none\"/></div><div><br clear=\"none\"/></div></en-note>",
      <<224, 142, 222, 77, 133, 184, 83, 71, 40, 126, 14, 48, 128, 249, 99, 18>>,
      203, 1424066828000, 1424066857000, :undefined, true, 19,
      "ebaf248b-667b-4511-beb5-ab3e8749d38d",
      ["98590060-4eaa-44fe-8514-50cb158742c2"], :undefined,
      {:NoteAttributes, :undefined, :undefined, :undefined, :undefined,
       "jevernotedev", :undefined, :undefined, :undefined, :undefined, :undefined,
       :undefined, :undefined, :undefined, :undefined, :undefined, :undefined,
       :undefined, :undefined, :undefined}, :undefined}}

Testing
-------

For testing, you'll need an Evernote Sandbox account and a personal
[developer token](https://sandbox.evernote.com/api/DeveloperToken.action):

    export EN_DEVELOPER_TOKEN="<your_token>"
    mix test

License
-------

Copyright 2015 Johan Wärlander

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
