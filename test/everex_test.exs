defmodule EverexTest do
  use ExUnit.Case

  @developer_token System.get_env("EN_DEVELOPER_TOKEN")

  test "retrieve notestore url using our API" do
    {:ok, client} = Everex.Client.new(@developer_token, sandbox: true)

    {:ok, url} = GenServer.call(
      client, {:userstore, :getNoteStoreUrl, []}
    )

    [prefix, postfix] = String.split(url, ~r"/s[0-9]+/")
    assert prefix == "https://sandbox.evernote.com/shard"
    assert postfix == "notestore"
  end
end
