defmodule PrimaOpentelemetryEx.Instrumentation.OpentelemetryEcto do
  @moduledoc false

  cond do
    not PrimaOpentelemetryEx.enabled?(:ecto) ->
      def maybe_setup, do: nil

    Code.ensure_loaded?(OpentelemetryEcto) ->
      def maybe_setup do
        :telemetry.attach(
          "repo-init-handler",
          [:ecto, :repo, :init],
          &__MODULE__.instrument_repo/4,
          %{}
        )
      end

      def instrument_repo(_event, _measurements, metadata, _config) do
        metadata
        |> Map.fetch!(:opts)
        |> Keyword.fetch!(:telemetry_prefix)
        |> OpentelemetryEcto.setup()
      end

    Code.ensure_loaded?(Ecto) ->
      raise """
      Ecto has been loaded without installing the optional opentelemetry_ecto dependency.
      PrimaOpentelemetryEx will not be able to instrument ecto unless you add it.

      Note: you can get rid of this warning by excluding absinthe from instrumentation with `config :prima_opentelemetry_ex, exclude: [:ecto]`
      """

    true ->
      def maybe_setup, do: nil
  end
end
