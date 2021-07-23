defmodule Everex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :everex,
      version: "0.1.1",
      name: "Everex",
      source_url: "https://github.com/jwarlander/everex",
      homepage_url: "https://github.com/jwarlander/everex",
      elixir: "~> 1.0",
      description: """
      Evernote API client for Elixir

      NOTE: Everex is UNDER DEVELOPMENT, and is NOT ready for production use.
      Feedback and contributions (via pull requests) are very welcome, of
      course!

      UPDATE: There is now an example showing how to get access using the
      OAuth authentication process. See `examples/oauth.exs`.
      """,
      package: [
        contributors: ["Johan Wärlander"],
        licenses: ["Apache 2.0"],
        links: %{ "GitHub": "https://github.com/jwarlander/everex" },
        files: [ 
          "lib", "priv", "mix.exs", "README*", "LICENSE*",
          "CHANGELOG*", "include", "src"
        ],
     ],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :ssl, :inets, :httpoison, :cowboy, :plug]]
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
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev},
      {:oauther, "~> 1.0.1"},
      {:httpoison, "~> 0.6.2"},
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.12.0"},
    ]
  end
end
