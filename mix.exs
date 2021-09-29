defmodule PrimaOpentelemetryEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :prima_opentelemetry_ex,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:opentelemetry, "~> 1.0.0-rc.1"},
      {:opentelemetry_absinthe, git: "git@github.com:primait/opentelemetry_absinthe.git", branch: "wizard"},
      {:opentelemetry_exporter, "~> 1.0.0-rc.1"}
    ]
  end
end
