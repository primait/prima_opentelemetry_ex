defmodule PrimaOpentelemetryEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :prima_opentelemetry_ex,
      version: "0.1.1",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      included_applications: [:opentelemetry, :opentelemetry_ecto, :opentelemetry_exporter]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:telemetry, "~> 0.4"}
    ] ++
      opentelemetry_core_deps() ++
      opentelemetry_instrumentation_deps()
  end

  defp opentelemetry_core_deps do
    [
      {:opentelemetry, "1.0.0-rc.2"},
      {:opentelemetry_api, "1.0.0-rc.2"},
      {:opentelemetry_exporter, "1.0.0-rc.1"}
    ]
  end

  defp opentelemetry_instrumentation_deps do
    [
      {:opentelemetry_absinthe, "1.0.0-rc.5"},
      {:opentelemetry_ecto, "1.0.0-rc.1"},
      {:teleplug, "1.0.0-rc.4", github: "primait/teleplug"},
      {:telepoison, "1.0.0-rc.4"}
    ]
  end
end
