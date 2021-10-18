defmodule PrimaOpentelemetryEx.ResourceDetectorTest do
  use ExUnit.Case, async: true

  describe "use default service name and version if env vars aren't set" do
    assert {:otel_resource, resource} = PrimaOpentelemetryEx.ResourceDetector.get_resource([])

    assert {'service.name', 'prima-opentelemetry-service'} =
             List.keyfind(resource, 'service.name', 0)

    assert {'service.version', '0.0.0-dev'} = List.keyfind(resource, 'service.version', 0)
  end

  describe "use APP_NAME env var to set service.name" do
    System.put_env("APP_NAME", "test")
    assert {:otel_resource, resource} = PrimaOpentelemetryEx.ResourceDetector.get_resource([])
    assert {'service.name', 'test'} = List.keyfind(resource, 'service.name', 0)
  end

  describe "use VERSION env var to set service.version" do
    System.put_env("VERSION", "1.2.3-test")
    assert {:otel_resource, resource} = PrimaOpentelemetryEx.ResourceDetector.get_resource([])
    assert {'service.version', '1.2.3-test'} = List.keyfind(resource, 'service.version', 0)
  end
end
