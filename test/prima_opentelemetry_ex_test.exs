defmodule PrimaOpentelemetryExTest do
  use ExUnit.Case, async: false

  import Mock

  describe "setup" do
    setup do
      Application.put_env(:prima_opentelemetry_ex, :enabled, true)
    end

    test "disable metrics for telepoison when configured" do
      with_mock Telepoison, setup: fn -> "" end do
        Application.put_env(:prima_opentelemetry_ex, :except, [:telepoison])

        PrimaOpentelemetryEx.setup()

        assert_not_called(Telepoison.setup())
      end
    end
  end
end
