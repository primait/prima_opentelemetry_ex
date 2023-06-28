defmodule PrimaOpentelemetryEx.Instrumentation.OpentelemetryAbsinthe do
  @moduledoc false
  alias PrimaOpentelemetryEx.Instrumentation.Optional
  require Optional

  Optional.create to_instrument: Absinthe,
                  instrumenting_library: OpentelemetryAbsinthe,
                  feature_name: :absinthe do
    :prima_opentelemetry_ex
    |> Application.get_env(:graphql, [])
    |> OpentelemetryAbsinthe.Instrumentation.setup()
  end
end
