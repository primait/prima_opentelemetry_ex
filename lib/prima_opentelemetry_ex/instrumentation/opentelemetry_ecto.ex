defmodule PrimaOpentelemetryEx.Instrumentation.OpentelemetryEcto do
  @moduledoc false

  alias PrimaOpentelemetryEx.Instrumentation.Optional
  require Optional

  def repo_init_handler(_event, _measurements, metadata, _config) do
    metadata
    |> Map.fetch!(:opts)
    |> Keyword.fetch!(:telemetry_prefix)
    |> OpentelemetryEcto.setup(Application.get_env(:prima_opentelemetry_ex, :ecto, []))
  end

  Optional.instrument Ecto,
    with: OpentelemetryEcto,
    feature: :ecto do
    :telemetry.attach(
      "repo-init-handler",
      [:ecto, :repo, :init],
      &__MODULE__.repo_init_handler/4,
      %{}
    )
  end
end
