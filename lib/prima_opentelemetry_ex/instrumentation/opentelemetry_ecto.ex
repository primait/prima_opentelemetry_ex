defmodule PrimaOpentelemetryEx.Instrumentation.OpentelemetryEcto do
  @moduledoc false

  alias PrimaOpentelemetryEx.Instrumentation.Optional
  require Optional

  Optional.instrument Ecto,
    with: OpentelemetryEcto,
    feature: :ecto do
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
