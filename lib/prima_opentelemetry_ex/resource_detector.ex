defmodule PrimaOpentelemetryEx.ResourceDetector do
  @moduledoc """
  Module implementing the `:otel_resource_detector`.
  It reads `APP_NAME` and `VERSION` env variables to use them as `service.name`
  and `service.version` tags.
  """

  @behaviour :otel_resource_detector

  @impl :otel_resource_detector
  def get_resource(_config) do
    {:otel_resource,
     [
       {'service.name',
        "APP_NAME" |> System.get_env("prima-opentelemetry-service") |> to_charlist()},
       {'service.version', "VERSION" |> System.get_env("0.0.0-dev") |> to_charlist()}
     ]}
  end
end
