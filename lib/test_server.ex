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
defmodule Everex.NoteStore.TestServer do
  #require Record
  #Record.defrecord :Tag, Record.extract(:Tag, from_lib: "edam/include/types_types.hrl")

  def go(), do: go([])
  def go(args) do
    spawn fn -> start_link(9090, []); receive do after :infinity -> :ok end end
  end

  def start_link(port, server_opts) do
    :thrift_socket_server.start([{:handler, __MODULE__},
                                 {:service, :note_store_thrift},
                                 {:port, port}] ++ server_opts)
  end

  def stop(pid) do
    :thrift_socket_server.stop(pid)
  end

  def handle_function(listTags, {token}) when is_binary(token) do
    {:reply, [
        {:'Tag', String.to_char_list(token), "", "", 0},
      ]}
  end
end
