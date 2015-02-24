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
  require Record

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

end
