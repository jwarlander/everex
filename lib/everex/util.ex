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

  defmacro deftype(mod, record, opts) do
    quote do
      def record_to_struct(the_record)
      when Record.is_record(the_record, unquote(record))
      do
        record_def = Record.extract(unquote(record), unquote(opts))
        record_values = the_record |> Tuple.to_list |> Enum.drop(1)
        do_record_to_struct(unquote(record), record_values, record_def,
                            struct(__MODULE__.unquote(mod)))
      end

      defp do_record_to_struct(unquote(record), [], [], acc), do: acc
      defp do_record_to_struct(
        unquote(record), [value|vt], [{key,:undefined}|dt], acc
      ) do
        do_record_to_struct(
          unquote(record), vt, dt, struct(acc,[{key, value}])
        )
      end

      defmodule unquote(mod) do
        @derive [Access, Collectable]
        defstruct Record.extract(unquote(record), unquote(opts))

        Record.defrecord :record,
          unquote(record),
          Record.extract(unquote(record), unquote(opts))

        def to_record(map = %__MODULE__{}) do
          map
          |> Everex.Util.struct_to_record(
              Record.extract(unquote(record), unquote(opts)),
              unquote(record)
          )
        end
      end
    end
  end
end
