defmodule PrimaOpentelemetryEx do
  @moduledoc """
  Swiss knife module for opentelemetry instrumentation.
  It can be used to setup instrument:
  - Teleplug
  - Telepoison
  - OpentelemetryAbsinthe
  - OpentelemetryEcto
  """

  @doc """
  Setup all the opentelemetry instrumentation.
  You are supposed to call it in your application start function.
  """
  def setup do
    if Application.get_env(:prima_opentelemetry_ex, :enabled, true) do
      register_resource_detector()
      set_processor()
      instrument()
      Application.ensure_all_started(:opentelemetry_exporter)
    end

    :ok
  end

  defp instrument do
    Telepoison.setup()
    Teleplug.setup()

    :prima_opentelemetry_ex
    |> Application.get_env(:graphql, [])
    |> OpentelemetryAbsinthe.Instrumentation.setup()

    :telemetry.attach(
      "repo-init-handler",
      [:ecto, :repo, :init],
      &instrument_repo/4,
      %{}
    )
  end

  defp instrument_repo(_event, _measurements, metadata, _config) do
    metadata
    |> Map.fetch!(:opts)
    |> Keyword.fetch!(:telemetry_prefix)
    |> OpentelemetryEcto.setup()
  end

  def register_resource_detector do
    detectors = Application.get_env(:opentelemetry, :resource_detectors, [])

    Application.put_env(
      :opentelemetry,
      :resource_detectors,
      detectors ++ [PrimaOpentelemetryEx.ResourceDetector],
      persistent: true
    )
  end

  defp set_processor do
    # set opentelemetry processors configuration only if NOT already set by something else
    with [] <- Application.get_env(:opentelemetry, :processors) do
      endpoint = Application.get_env(:prima_opentelemetry_ex, :endpoint, [])
      protocol = Keyword.get(endpoint, :protocol, :http)
      host = Keyword.get(endpoint, :host, "jaeger")
      port = Keyword.get(endpoint, :port, 55_681)

      Application.put_env(
        :opentelemetry,
        :processors,
        [
          {:otel_batch_processor,
           %{
             exporter: {:opentelemetry_exporter, %{endpoints: [{protocol, host, port, []}]}}
           }}
        ],
        persistent: true
      )
    end
  end
end
