defmodule PrimaOpentelemetryEx do
  require Logger

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
      set_resource()
      set_processor()
      instrument()

      {:ok, _} = Application.ensure_all_started(:opentelemetry_exporter)
      {:ok, _} = Application.ensure_all_started(:opentelemetry)
    end

    :ok
  end

  defp enabled?(feature) do
    excluded_libraries = Application.get_env(:prima_opentelemetry_ex, :exclude, [])
    !Enum.member?(excluded_libraries, feature)
  end

  defp instrument do
    maybe_setup_telepoison()
    maybe_setup_teleplug()
    maybe_setup_otel_absinthe()

    if enabled?(:ecto) do
      :telemetry.attach(
        "repo-init-handler",
        [:ecto, :repo, :init],
        &__MODULE__.instrument_repo/4,
        %{}
      )
    end
  end

  if Code.ensure_loaded?(Telepoison) do
    def maybe_setup_telepoison, do: Telepoison.setup()
  else
    def maybe_setup_telepoison, do: nil
  end

  if Code.ensure_loaded?(Teleplug) do
    def maybe_setup_teleplug, do: Teleplug.setup()
  else
    def maybe_setup_teleplug, do: nil
  end

  def maybe_setup_otel_absinthe do
    enabled = enabled?(:absinthe)
    absinthe_loaded = Code.ensure_loaded?(Absinthe)

    maybe_setup_otel_absinthe(enabled, absinthe_loaded)
  end

  @spec maybe_setup_otel_absinthe(
          enabled :: boolean(),
          absinthe_loaded :: boolean()
        ) :: nil
  if Code.ensure_loaded?(OpentelemetryAbsinthe) do
    def maybe_setup_otel_absinthe(true, _) do
      :prima_opentelemetry_ex
      |> Application.get_env(:graphql, [])
      |> OpentelemetryAbsinthe.Instrumentation.setup()

      nil
    end
  else
    def maybe_setup_otel_absinthe(true, true) do
      Logger.warn("""
      Absinthe has been loaded without installing the optional opentelemetry_absinthe dependency.
      PrimaOpentelemetryEx will not be able to instrument absinthe unless you add it.

      Note: you can get rid of this warning by excluding absinthe from instrumentation with `config :prima_opentelemetry_ex, exclude: [:absinthe]`
      """)
    end
  end

  def maybe_setup_otel_absinthe(_, _), do: nil

  def instrument_repo(_event, _measurements, metadata, _config) do
    metadata
    |> Map.fetch!(:opts)
    |> Keyword.fetch!(:telemetry_prefix)
    |> OpentelemetryEcto.setup()
  end

  def set_resource do
    Application.put_env(
      :opentelemetry,
      :resource,
      %{
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
