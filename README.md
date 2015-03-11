[![Build Status](https://travis-ci.org/jwarlander/everex.svg?branch=master)](https://travis-ci.org/jwarlander/everex)

Everex is an Evernote API client for Elixir. It uses a modified version of the
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

Everex now represents Thrift data structures as `structs`, to keep client usage
idiomatic and the data more self-explanatory. See examples below.

_**UPDATE:** There is now an example showing how to get access using the OAuth
authentication process. See `examples/oauth.exs`. This requires having an
[API key](https://dev.evernote.com/doc/articles/authentication.php), of course,
and exporting the environment variables EN_CONSUMER_KEY / EN_CONSUMER_SECRET
before running the example._

Usage
-----

Add Everex to your dependencies in `mix.exs`:

```elixir
  defp deps do
    [{:everex, "~> 0.1.1"}]
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

```elixir
iex(1)> {:ok, client} = Everex.Client.new(System.get_env("EN_DEVELOPER_TOKEN"), sandbox: true)
{:ok, #PID<0.1295.0>}
iex(2)> client |> Everex.NoteStore.list_tags
{:ok,
 [%Everex.Types.Tag{guid: "98590060-4eaa-44fe-8514-50cb158742c2",
   name: "one_tag", parentGuid: :undefined, updateSequenceNum: 20},
  %Everex.Types.Tag{guid: "f8484cd9-f213-4072-9df5-c0ab49f79fe3",
   name: "another_tag", parentGuid: :undefined, updateSequenceNum: 22}]}
iex(3)> tag_filter = %Everex.Types.NoteFilter{tagGuids: ["98590060-4eaa-44fe-8514-50cb158742c2"]}
%Everex.Types.NoteFilter{ascending: :undefined, emphasized: :undefined,
 inactive: :undefined, notebookGuid: :undefined, order: :undefined,
 tagGuids: ["98590060-4eaa-44fe-8514-50cb158742c2"], timeZone: :undefined,
 words: :undefined}
iex(4)> client |> Everex.NoteStore.find_notes_metadata(tag_filter)
{:ok,
 %Everex.Types.NotesMetadataList{notes: [%Everex.Types.NoteMetadata{attributes: :undefined,
    contentLength: :undefined, created: :undefined, deleted: :undefined,
    guid: "9a6cbc15-613c-4e77-b184-76829421c3db",
    largestResourceMime: :undefined, largestResourceSize: :undefined,
    notebookGuid: :undefined, tagGuids: :undefined, title: :undefined,
    updateSequenceNum: :undefined, updated: :undefined}],
  searchedWords: :undefined, startIndex: 0, stoppedWords: :undefined,
  totalNotes: 1, updateCount: 22}}
iex(5)> client |> Everex.NoteStore.get_note("9a6cbc15-613c-4e77-b184-76829421c3db",true)
{:ok,
 %Everex.Types.Note{active: true,
  attributes: %Everex.Types.NoteAttributes{altitude: :undefined,
   applicationData: :undefined, author: "jevernotedev",
   classifications: :undefined, contentClass: :undefined, creatorId: :undefined,
   lastEditedBy: :undefined, lastEditorId: :undefined, latitude: :undefined,
   longitude: :undefined, placeName: :undefined, reminderDoneTime: :undefined,
   reminderOrder: :undefined, reminderTime: :undefined, shareDate: :undefined,
   source: :undefined, sourceApplication: :undefined, sourceURL: :undefined,
   subjectDate: :undefined},
  content: "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">\n<en-note><div>We'll tag these, too!<br clear=\"none\"/></div><div><br clear=\"none\"/></div></en-note>",
  contentHash: <<224, 142, 222, 77, 133, 184, 83, 71, 40, 126, 14, 48, 128, 249, 99, 18>>,
  contentLength: 203, created: 1424066828000, deleted: :undefined,
  guid: "9a6cbc15-613c-4e77-b184-76829421c3db",
  notebookGuid: "ebaf248b-667b-4511-beb5-ab3e8749d38d", resources: :undefined,
  tagGuids: ["98590060-4eaa-44fe-8514-50cb158742c2"], tagNames: :undefined,
  title: "Another test, to be sure", updateSequenceNum: 19,
  updated: 1424066857000}}
```

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
