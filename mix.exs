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
      extra_applications: [:logger],
      additional_applications: [:opentelemetry, :opentelemetry_absinthe, :opentelemetry_exporter]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:opentelemetry, "~> 1.0.0-rc.1"},
      {:opentelemetry_absinthe, "~> 1.0.0-rc.4"},
      {:opentelemetry_ecto, "~> 1.0.0-rc.1"},
      {:opentelemetry_exporter, "~> 1.0.0-rc.1"},
      {:teleplug, "~> 1.0.0-rc.2", github: "primait/teleplug"},
      {:telepoison, "~> 1.0.0-rc.4"}
    ]
  end
end
