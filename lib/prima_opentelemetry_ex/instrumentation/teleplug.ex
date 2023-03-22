defmodule PrimaOpentelemetryEx.Instrumentation.Teleplug do
  @moduledoc false

  if Code.ensure_loaded?(Teleplug) do
    def maybe_setup, do: Teleplug.setup()
  else
    def maybe_setup, do: nil
  end
end
