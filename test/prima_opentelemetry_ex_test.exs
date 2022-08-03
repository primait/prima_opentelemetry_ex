defmodule PrimaOpentelemetryExTest do
  use ExUnit.Case, async: false

  import Mock

  describe "" do
    test "Cristiano e' bravo" do
      with_mock Telepoison, setup: fn -> "" end do
        Application.put_env(
          :prima_opentelemetry_ex,
          :enabled,
          true
        )

        Application.put_env(
          :prima_opentelemetry_ex,
          :except,
          [:telepoison]
        )

        PrimaOpentelemetryEx.setup()
        assert_not_called(Telepoison.setup())
      end
    end
  end
end
