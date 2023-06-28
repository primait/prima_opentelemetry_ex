defmodule PrimaOpentelemetryEx.Instrumentation.OpentelemetryEcto do
  @moduledoc false

  alias PrimaOpentelemetryEx.Instrumentation.Optional
  require Optional

  Optional.create to_instrument: Ecto,
                  instrumenting_library: OpentelemetryEcto,
                  feature_name: :ecto do
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
end
