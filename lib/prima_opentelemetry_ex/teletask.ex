defmodule PrimaOpentelemetryEx.TeleTask do
  @moduledoc """
  Wrapper of Task that mantains the span context
  """

  require OpenTelemetry.Tracer, as: Tracer
  require Logger

  @spec start((() -> any())) :: {:ok, pid()}
  def start(fun) do
    ctx = Tracer.current_span_ctx()
    meta = Logger.metadata()

    Task.start(fn ->
      Tracer.set_current_span(ctx)
      Logger.metadata(meta)
      fun.()
    end)
  end

  @spec async((() -> any)) :: Task.t()
  def async(fun) do
    ctx = Tracer.current_span_ctx()
    meta = Logger.metadata()

    Task.async(fn ->
      Tracer.set_current_span(ctx)
      Logger.metadata(meta)
      fun.()
    end)
  end

  @spec await(Task.t()) :: term
  def await(t) do
    Task.await(t)
  end
end
