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

defmodule Everex.Types do
  require Record

  defmodule Note do
  @note_record Record.extract(:Note, from: "include/types_types.hrl")

    @derive [Access, Collectable]
    defstruct Record.extract(:Note, from: "include/types_types.hrl")

    Record.defrecord :note, :Note,
      Record.extract(:Note, from: "include/types_types.hrl")

    def new(record) when Record.is_record(record, :Note) do
      note(record) |> Enum.into(%Note{}) 
    end

    def to_record(note = %Note{}) do
      Everex.Util.struct_to_record(note, @note_record, :Note)
    end
  end
end
