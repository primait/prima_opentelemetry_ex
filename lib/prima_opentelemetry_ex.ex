defmodule PrimaOpentelemetryEx do
  @moduledoc """
  Documentation for `PrimaOpentelemetryEx`.
  """

  @doc """
  Setup all the opentelemetry instrumentation.
  You are supposed to call it in your application start function.
  """
  def setup() do
    
    :prima_opentelemetry_ex |> Application.get_env(:graphql) |> OpentelemetryAbsinthe.Instrumentation.setup()

    :ok
  end
end
