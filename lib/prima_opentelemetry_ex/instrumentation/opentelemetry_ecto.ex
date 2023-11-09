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
      fn _event, _measurements, metadata, _config ->
    	metadata
    	|> Map.fetch!(:opts)
    	|> Keyword.fetch!(:telemetry_prefix)
    	|> OpentelemetryEcto.setup()
  	end,
      %{}
    )
  end
end
