defmodule Everex.NoteStore do
  def list_tags(client) do
    GenServer.call(client, {:notestore, :listTags, []})
  end
end
