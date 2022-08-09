defmodule PrimaOpentelemetryExTest do
  use ExUnit.Case, async: false

  import Mock

  describe "setup" do
    setup do
      Application.put_env(:prima_opentelemetry_ex, :enabled, true)
    end

    test "disable tracing for absinthe when configured" do
      with_mock OpentelemetryAbsinthe.Instrumentation, setup: fn _ -> "" end do
        Application.put_env(:prima_opentelemetry_ex, :exclude, [:absinthe])

        PrimaOpentelemetryEx.setup()

        assert_not_called(OpentelemetryAbsinthe.Instrumentation.setup(:_))
      end
    end

    test "disable tracing for ecto when configured" do
      with_mock :telemetry, attach: fn _, _, _, _ -> "" end do
        Application.put_env(:prima_opentelemetry_ex, :exclude, [:ecto])

        PrimaOpentelemetryEx.setup()

        assert_not_called(:telemetry.attach("repo-init-handler", :_, :_, :_))
      end
    end
  end
end
