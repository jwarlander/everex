defmodule Everex.Client do
  use GenServer

  defstruct auth_token: nil, server: nil, user_client: nil, note_client: nil

  @production_server "evernote.com"
  @sandbox_server "sandbox.evernote.com"

  ## Client API

  def new(auth_token, opts \\ []) do
    srv = case opts[:sandbox] do
      true -> @sandbox_server
      _else -> @production_server
    end
    state = %__MODULE__{auth_token: auth_token, server: srv}
    GenServer.start(__MODULE__, state)
  end

  ## Server Callbacks

  def init(state = %__MODULE__{server: srv}) do
    {:ok, client} = thrift_client_util(srv, "/edam/user", :user_store_thrift)
    { :ok, %{state | user_client: client}, 0 }
  end

  def handle_info(:timeout, state = %__MODULE__{user_client: user_client}) do
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
        { :noreply, %{state | user_client: user_client, note_client: note_client} }
      _else ->
        # TODO: retrying notestore connection; log something..
        { :noreply, %{state | user_client: user_client}, 5000 }
    end
  end

  def handle_call({:notestore, thrift_call, thrift_opts}, _from, state)
  when is_atom(thrift_call) and is_list(thrift_opts)
  do
    {new_client, response} = :thrift_client.call(
      state.note_client, thrift_call, [state.auth_token | thrift_opts]
    )
    { :reply, response, %{state | note_client: new_client} }
  end

  def handle_call({:userstore, thrift_call, thrift_opts}, _from, state)
  when is_atom(thrift_call) and is_list(thrift_opts)
  do
    {new_client, response} = :thrift_client.call(
      state.user_client, thrift_call, [state.auth_token | thrift_opts]
    )
    { :reply, response, %{state | user_client: new_client} }
  end

  ## Private Functions

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
end
