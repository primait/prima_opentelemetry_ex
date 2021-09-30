defmodule PrimaOpentelemetryEx do
  @moduledoc """
  Documentation for `PrimaOpentelemetryEx`.
  """

  @doc """
  Setup all the opentelemetry instrumentation.
  You are supposed to call it in your application start function.
  """
  def setup do
    if Application.get_env(:prima_opentelemetry_ex, :enabled, true) do
      instrument()
      set_opentelemetry_env()
      Application.start(:opentelemetry_exporter)
    end

    :ok
  end

  defp instrument do
    :prima_opentelemetry_ex
    |> Application.get_env(:graphql, [])
    |> OpentelemetryAbsinthe.Instrumentation.setup()

    :prima_opentelemetry_ex
    |> Application.get_env(:repositories, [])
    |> Enum.each(&instrument_repo/1)

    Telepoison.setup()
  end

  defp instrument_repo(repo) do
    repo |> telemetry_prefix() |> OpentelemetryEcto.setup()
  end

  defp set_opentelemetry_env do
    endpoint = Application.get_env(:prima_opentelemetry_ex, :endpoint, [])
    protocol = Keyword.get(endpoint, :protocol, :http)
    host = Keyword.get(endpoint, :host, "jaeger")
    port = Keyword.get(endpoint, :port, 55681)

    Application.put_env(:opentelemetry, :processors,
      otel_batch_processor: %{
        exporter: {:opentelemetry_exporter, %{endpoints: [{protocol, host, port, []}]}}
      },
      permanent: true
    )
  end

  # taken from https://github.com/elixir-ecto/ecto/blob/42e3e693aa48da318e6fc202ee0fd18cb5da1f36/lib/ecto/repo/supervisor.ex#L35
  defp telemetry_prefix(repo) do
    repo
    |> Module.split()
    |> Enum.map(&(&1 |> Macro.underscore() |> String.to_atom()))
  end
end
