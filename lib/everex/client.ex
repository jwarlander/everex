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
defmodule Everex.Client do
  use GenServer
  require Record

  alias Everex.Types

  defstruct auth_token: nil, server: nil, user_client: nil, note_client: nil

  @production_server "evernote.com"
  @sandbox_server "sandbox.evernote.com"

  @timeout 20_000

  ## Client API

  @doc """
  Starts a new client. To connect to the Evernote Sandbox, pass the
  `sandbox: true` option.
  """
  def new(auth_token, opts \\ []) do
    srv = case opts[:sandbox] do
      true -> @sandbox_server
      _else -> @production_server
    end
    state = %__MODULE__{auth_token: auth_token, server: srv}
    GenServer.start(__MODULE__, state)
  end

  @doc """
  Makes a call to the underlying Thrift service. Normally used only by
  the Everex API calls, but may also be useful if a particular Evernote
  Thrift function isn't yet implemented.
  """
  def thrift_call(client, service, call, args \\ [], timeout \\ @timeout) do
    GenServer.call(client, {service, call, convert_structs(args)}, timeout)
  end

  ## Server Callbacks

  def init(state = %__MODULE__{server: srv}) do
    {:ok, client} = thrift_client_util(srv, "/edam/user", :user_store_thrift)
    { :ok, %{state | user_client: client} }
  end

  def handle_call(call = {:notestore, _, _}, from,
                  state = %__MODULE__{note_client: nil})
  do
    {:ok, state} = connect(state)
    handle_call(call, from, state)
  end
  def handle_call({:notestore, call, thrift_opts}, _from, state)
  when is_atom(call) and is_list(thrift_opts)
  do
    args = [state.auth_token | thrift_opts]
    {new_client, response} = make_thrift_call(state.note_client, call, args)
    { :reply, response, %{state | note_client: new_client} }
  end
  def handle_call({:userstore, call, thrift_opts}, _from, state)
  when is_atom(call) and is_list(thrift_opts)
  do
    args = [state.auth_token | thrift_opts]
    {new_client, response} = make_thrift_call(state.user_client, call, args)
    { :reply, response, %{state | user_client: new_client} }
  end

  ## Private Functions

  defp connect(state = %__MODULE__{user_client: user_client}) do
    response = :thrift_client.call(
      user_client, :getNoteStoreUrl, [state.auth_token]
    )
    case response do
      {user_client, {:ok, url}} ->
        [base, path] = String.split(url, ~r"/shard/")
        srv = String.replace(base, "https://", "")
        {:ok, note_client} = thrift_client_util(
          srv, "/shard/" <> path, :note_store_thrift
        )
        { :ok, %{state | user_client: user_client, note_client: note_client} }
      {user_client, error} ->
        { :error, %{state | user_client: user_client}, error}
    end
  end

  defp thrift_client_util(srv, path, module) when is_binary(srv) do
    thrift_client_util(String.to_char_list(srv), path, module)
  end
  defp thrift_client_util(srv, path, module) when is_binary(path) do
    thrift_client_util(srv, String.to_char_list(path), module)
  end
  defp thrift_client_util(srv, path, module) when is_atom(module) do
    {:ok, transport} = :thrift_https_transport.new(srv, path)
    {:ok, protocol} = :thrift_binary_protocol.new(transport, [])
    :thrift_client.new(protocol, module)
  end

  defp make_thrift_call(client, call, args) do
    try do
      :thrift_client.call(client, call, args)
    catch
      {new_client, {:exception, what}} ->
        {new_client, {:exception, what}}
    end
    |> process_thrift_response
  end

  defp process_thrift_response({client, {status, response}}) do
    {client, {status, convert_records(response)}}
  end

  defp convert_records(value) when Record.is_record(value) do 
    Types.to_struct(value)
  end
  defp convert_records(value) when is_list(value) do
    convert_records_in_list(value, [])
  end
  defp convert_records(value), do: value

  defp convert_records_in_list([], acc), do: Enum.reverse(acc)
  defp convert_records_in_list([head|tail], acc) do
    convert_records_in_list(tail, [convert_records(head)|acc])
  end

  defp convert_structs(%{} = value) do 
    Types.to_record(value)
  end
  defp convert_structs(value) when is_list(value) do
    convert_structs_in_list(value, [])
  end
  defp convert_structs(value), do: value

  defp convert_structs_in_list([], acc), do: Enum.reverse(acc)
  defp convert_structs_in_list([head|tail], acc) do
    convert_structs_in_list(tail, [convert_structs(head)|acc])
  end
end
