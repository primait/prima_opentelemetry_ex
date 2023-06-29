defmodule PrimaOpentelemetryEx.Instrumentation.OpentelemetryAbsinthe do
  @moduledoc false
  alias PrimaOpentelemetryEx.Instrumentation.Optional
  require Optional

  Optional.instrument Absinthe,
    with: OpentelemetryAbsinthe,
    feature: :absinthe do
    :prima_opentelemetry_ex
    |> Application.get_env(:graphql, [])
    |> OpentelemetryAbsinthe.Instrumentation.setup()
  end
end
