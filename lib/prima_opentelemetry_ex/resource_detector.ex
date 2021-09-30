defmodule PrimaOpentelemetryEx.ResourceDetector do
  @behaviour :otel_resource_detector

  @impl :otel_resource_detector
  def get_resource(_config) do
    {:otel_resource,
     [
       {"service.name", System.get_env("APP_NAME", "prima-opentelemetry-service")},
       {"service.version", System.get_env("VERSION", "0.0.0-dev")}
     ]}
  end
end
