case System.get_env("EN_DEVELOPER_TOKEN") do
  nil -> 
    IO.puts("ERROR: To run tests, define environment variable EN_DEVELOPER_TOKEN")
  _else ->
    ExUnit.start()
end
