defmodule PrimaOpentelemetryEx.Instrumentation.OpentelemetryAbsinthe do
  @moduledoc false

  cond do
    Code.ensure_loaded?(OpentelemetryAbsinthe) ->
      def maybe_setup do
        if PrimaOpentelemetryEx.enabled?(:absinthe) do
          :prima_opentelemetry_ex
          |> Application.get_env(:graphql, [])
          |> OpentelemetryAbsinthe.Instrumentation.setup()
        else
          nil
        end
      end

    Code.ensure_loaded?(Absinthe) ->
      raise """
      Absinthe has been loaded without installing the optional opentelemetry_absinthe dependency.
      PrimaOpentelemetryEx will not be able to instrument absinthe unless you add it.

      Note: you can get rid of this warning by excluding absinthe from instrumentation with `config :prima_opentelemetry_ex, exclude: [:absinthe]`
      """

    true ->
      def maybe_setup, do: nil
  end
end
