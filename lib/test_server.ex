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
