defmodule Everex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :everex,
      version: "0.0.1",
      elixir: "~> 1.0",
      description: """
      Evernote API client for Elixir

      NOTE: Everex is UNDER DEVELOPMENT, and is NOT ready for production use.
      Feedback and contributions (via pull requests) are very welcome, of
      course!
      """,
      package: [
        contributors: ["Johan Wärlander"],
        licenses: ["Apache 2.0"],
        links: %{ github: "https://github.com/jwarlander/everex" },
        files: [ 
          "lib", "priv", "mix.exs", "README*", "LICENSE*",
          "CHANGELOG*", "erl_src"
        ],
     ],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :thrift]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:thrift, path: "erl_src/thrift"},
      {:edam, path: "erl_src/edam"},
    ]
  end
end
