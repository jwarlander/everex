defmodule Thrift.Mixfile do
  use Mix.Project

  def project do
    [app: :thrift,
     description: "Thrift bindings",
     version: "1.0.0-dev",
     language: :erlang,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      applications: [:kernel, :stdlib, :ssl, :inets],
      env: [exceptions_include_traces: true]
    ]
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
    []
  end
end
