defmodule PrimaOpentelemetryEx.ResourceDetector do
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
