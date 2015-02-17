defmodule ThriftTest do
  use ExUnit.Case

  @developer_token System.get_env("EN_DEVELOPER_TOKEN")

  test "start a test server and make a call" do
    {:ok, server} = Everex.NoteStore.TestServer.start_link(9090, [])
    {:ok, client} = :thrift_client_util.new('127.0.0.1', 9090, :note_store_thrift, [])
    {_client, result} = :thrift_client.call(client, :listTags, ["MyToken"])
    assert result == {:ok, [{:'Tag', "MyToken", "", "", 0}]}
    Everex.NoteStore.TestServer.stop(server)
  end

  test "retrieve notestore url using :thrift_client and developer token" do
    {:ok, transport} = :thrift_https_transport.new(
      'sandbox.evernote.com', '/edam/user'
    )
    {:ok, protocol} = :thrift_binary_protocol.new(transport, [])
    {:ok, client} = :thrift_client.new(protocol, :user_store_thrift)

    {_client, {:ok, true}} = :thrift_client.call(
      client, :checkVersion, ['Evernote EDAMTest (Elixir)', 1, 25]
    )

    {_client, {:ok, url}} = :thrift_client.call(
      client, :getNoteStoreUrl, [@developer_token]
    )

    [prefix, postfix] = String.split(url, ~r"/s[0-9]+/")
    assert prefix == "https://sandbox.evernote.com/shard"
    assert postfix == "notestore"
  end
end
