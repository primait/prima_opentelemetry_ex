defmodule PrimaOpentelemetryEx.ResourceDetector do
  @moduledoc """
  Module implementing the `:otel_resource_detector`.
  It reads `APP_NAME` and `VERSION` env variables to use them as `service.name`
  and `service.version` tags.
  """

  @behaviour :otel_resource_detector
  
  # in spite of the erlang lib specs:
  # https://github.com/open-telemetry/opentelemetry-erlang/blob/fab724a81179ffd8fa1b1b283fb854e70f963b29/apps/opentelemetry/src/otel_resource.erl#L26)
  # when using charlists instead of binaries for values the tags get exported as blank strings
  @dialyzer {:nowarn_function, get_resource: 1}
  
  @impl :otel_resource_detector
  def get_resource(_config) do
    {:otel_resource,
     [
       {'service.name', "APP_NAME" |> System.get_env("prima-opentelemetry-service")},
       {'service.version', "VERSION" |> System.get_env("0.0.0-dev")}
     ]}
  end
end
