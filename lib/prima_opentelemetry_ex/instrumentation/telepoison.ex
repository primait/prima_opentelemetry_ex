defmodule PrimaOpentelemetryEx.Instrumentation.Telepoison do
  @moduledoc false

  if Code.ensure_loaded?(Telepoison) do
    def maybe_setup, do: Telepoison.setup()
  else
    def maybe_setup, do: nil
  end
end
