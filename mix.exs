defmodule GithubTrendBot.Mixfile do
  use Mix.Project

  def project do
    [
      app: :github_trend_bot,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {GithubTrendBot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.13.0"},
      {:floki, "~> 0.18.0"},
      {:poison, "~> 3.1.0"},
      {:slack, "~> 0.12.0"}
    ]
  end
end
