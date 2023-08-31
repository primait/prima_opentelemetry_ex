defmodule PrimaOpentelemetryEx do
  require Logger
  alias PrimaOpentelemetryEx.Instrumentation

  @moduledoc """
  Swiss knife module for opentelemetry instrumentation.
  It can be used to setup instrumentation with:
  - Teleplug
  - Telepoison
  - OpentelemetryAbsinthe
  - OpentelemetryEcto
  (the libraries need to be installed separately)
  """

  @doc """
  Setup all the opentelemetry instrumentation.
  You are supposed to call it in your application start function.
  """
  def setup do
    if Application.get_env(:prima_opentelemetry_ex, :enabled, true) do
      set_resource()
      set_processor()
      instrument()

      {:ok, _} = Application.ensure_all_started(:opentelemetry_exporter)
      {:ok, _} = Application.ensure_all_started(:opentelemetry)
    end

    :ok
  end

  @doc false
  def enabled?(feature) do
    excluded_libraries = Application.get_env(:prima_opentelemetry_ex, :exclude, [])
    !Enum.member?(excluded_libraries, feature)
  end

  defp instrument do
    Instrumentation.Teleplug.maybe_setup()
    Instrumentation.OpentelemetryAbsinthe.maybe_setup()
    Instrumentation.OpentelemetryEcto.maybe_setup()
  end

  def set_resource do
    Application.put_env(
      :opentelemetry,
      :resource,
      %{
        "country" => System.get_env("COUNTRY", "undefined"),
        "deployment.environment" => System.get_env("APP_ENV", "dev"),
        "service.name" => System.get_env("APP_NAME", "prima-opentelemetry-service"),
        "service.version" => System.get_env("VERSION", "0.0.0-dev")
      }
    )
  end

  defp set_processor do
    # set opentelemetry processors configuration only if NOT already set by something else
    with [] <- Application.get_env(:opentelemetry, :processors, []) do
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
