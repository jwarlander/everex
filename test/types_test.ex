# 
# Copyright 2015 Johan Wärlander
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
defmodule EverexTypesTest do
  use ExUnit.Case

  require Everex.Types.Note
  alias Everex.Types.Note

  test "note record is the same as a note struct" do
    note_record = Note.note(title: "Foo Bar")
    note_struct = %Note{title: "Foo Bar"}
    assert Note.to_record(note_struct) == note_record
    assert Note.new(note_record) == note_struct
  end
end
