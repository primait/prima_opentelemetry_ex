defmodule PrimaOpentelemetryEx.MixProject do
  use Mix.Project

  @source_url "https://github.com/primait/prima_opentelemetry_ex"
  @version "1.0.0-rc.1"

  def project do
    [
      app: :prima_opentelemetry_ex,
      version: @version,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [
        plt_add_apps: [:mix, :ex_unit],
        plt_add_deps: :transitive,
        ignore_warnings: ".dialyzer_ignore.exs",
        list_unused_filters: true
      ],
      docs: docs(),
      package: package(),
      aliases: aliases()
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
      {:telemetry, "~> 0.4 or ~> 1.0"}
    ] ++
      opentelemetry_core_deps() ++
      opentelemetry_instrumentation_deps() ++
      dev_deps()
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
      {:teleplug, "1.0.0-rc.5", github: "primait/teleplug"},
      {:telepoison, "1.0.0-rc.4"}
    ]
  end

  defp dev_deps do
    [
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "1.1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.25.3", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      extras: [
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end

  def package do
    [
      description:
        "PrimaOpentelemetryEx is a utility library for opentelemetry instrumentation in Prima elixir projects.",
      name: "prima_opentelemetry_ex",
      maintainers: ["Matteo Busi"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp aliases do
    [
      c: "compile",
      "format.all": [
        "format mix.exs \"lib/**/*.{ex,exs}\" \"test/**/*.{ex,exs}\" \"config/**/*.{ex,exs}\""
      ]
    ]
  end
end
