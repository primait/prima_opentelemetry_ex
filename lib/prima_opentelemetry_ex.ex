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
    end
    :ok
  end

  def instrument do
    :prima_opentelemetry_ex
      |> Application.get_env(:graphql, [])
      |> OpentelemetryAbsinthe.Instrumentation.setup()
  end
end
