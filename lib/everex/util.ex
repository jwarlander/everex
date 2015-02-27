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
defmodule Everex.Util do

  defmacro __using__(_options) do
    quote do
      require Record
      require Everex.Util
      import Everex.Util, only: [deftype: 3]
    end
  end

  def record_to_struct(the_record, fields, struct_name) do
    [_tag | values] = the_record |> Tuple.to_list
    do_record_to_struct(values, fields, struct(struct_name))
  end

  defp do_record_to_struct([], [], acc), do: acc
  defp do_record_to_struct([value|vt], [{key,:undefined}|dt], acc) do
    do_record_to_struct(vt, dt, struct(acc,[{key, value}]))
  end

  def struct_to_record(the_struct, record_def, tag) do
    [ tag | do_struct_to_record(the_struct, record_def, []) ]
    |> List.to_tuple
  end

  defp do_struct_to_record(_the_struct, [], acc) do
    acc |> Enum.reverse
  end
  defp do_struct_to_record(the_struct, [{key, :undefined}|tail], acc) do
    do_struct_to_record(the_struct, tail, [the_struct[key]|acc])
  end

  defmacro deftype(mod, tag, fields) do
    quote do
      defmodule unquote(mod) do
        @derive [Access, Collectable]
        defstruct unquote(fields)

        Record.defrecord :record, unquote(tag), unquote(fields)
      end

      def to_record(map = %__MODULE__.unquote(mod){}) do
        Everex.Util.struct_to_record(map, unquote(fields), unquote(tag))
      end

      def to_struct(record) when Record.is_record(record, unquote(tag))
      do
        Everex.Util.record_to_struct(
          record, unquote(fields), __MODULE__.unquote(mod)
        )
      end
    end
  end
end
