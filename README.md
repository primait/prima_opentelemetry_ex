# PrimaOpentelemetryEx

[![Module Version](https://img.shields.io/hexpm/v/prima_opentelemetry_ex.svg)](https://hex.pm/packages/prima_opentelemetry_ex)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/prima_opentelemetry_ex/)
[![Total Download](https://img.shields.io/hexpm/dt/prima_opentelemetry_ex.svg)](https://hex.pm/packages/prima_opentelemetry_ex)
[![License](https://img.shields.io/hexpm/l/prima_opentelemetry_ex.svg)](https://github.com/primait/prima_opentelemetry_ex/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/primait/prima_opentelemetry_ex.svg)](https://github.com/primait/prima_opentelemetry_ex/commits/master)

This is your one-stop source of all things opentelemetry in elixir.
Add

```elixir
    {:prima_opentelemetry_ex, "~> 1.0.0"}
```

and the respective telemetry libraries to your dependencies and you are good to go.

What's covered:

- HTTPoison (via [Telepoison](https://github.com/primait/telepoison)) - to trace the http calls you make to external system and to pass along the trace context
- Plug - to link your phoenix/plug handled requests with their http clients traces
  * you will need to add teleplug to your pipeline
- Absinthe - to trace your GraphQL resolutions in a single span
  * you need to install `opentelemetry_absinthe`
- Ecto - to trace your database transactions in a single span
  * you also need to install `opentelemetry_ecto`

## Usage

To start collecting traces just put

``` elixir
PrimaOpentelemetryEx.setup()
```

in your application start function.

To trace your outgoing http calls you need to use the `Telepoison` module as a drop-in replacement for `HTTPoison`.
e.g.

``` elixir
Telepoison.post("https://example.com/", "{'example': 1}", %{"content-type" => "application/json"}, [timeout: 5_000])
```

For more informations see telepoison [usage](https://github.com/primait/telepoison#usage)

To emit server spans (from plug) you need to add `Teleplug` to your plug pipeline either in your phoenix endpoint module or in every pipeline you want to trace (contained in your router module if you are using phoenix).
e.g.

``` elixir
pipeline :example do
    plug Teleplug
    plug Plug.Logger
end
```

GraphQL and database spans are emitted automatically as long as the relevant telemetry libraries are installed.

To keep traces across elixir tasks you need to use `PrimaOpentelemetryEx.TeleTask` module that wraps `start/1`, `async/1` and `await/1`.

To see emitted traces on your local dev machine, you can use the [jaeger all-in-one image](https://hub.docker.com/r/jaegertracing/all-in-one/).  
To add it to your local Docker Compose setup, simply add a service (which your web container should depend on):

``` yaml
  jaeger:
    image: jaegertracing/all-in-one:1.35
    ports:
      - 16686:16686
    environment:
      COLLECTOR_OTLP_ENABLED: true
      COLLECTOR_OTLP_HTTP_HOST_PORT: 55681
```

You can then use the [jaeger UI](http://localhost:16686/search) to search for your traces.

Be advised that `prima_opentelemetry_ex` uses ENV vars to set service name and version inside the exported traces. Those values are important, for example, to make datadog correctly recognize services and their relative deployments (through version tracking); the two ENV var currently used are:

- `APP_NAME` for service name
- `VERSION` for service version

These are supposed to be correctly set up inside prima containers in production; if you want to you can set them up for local development through docker-compose, for example:

``` yaml
services:
  web:
    build: .
    volumes:
      - "~/.ssh:/home/app/.ssh"
      - "~/.aws:/home/app/.aws"
      - "~/.gitconfig:/home/app/.gitconfig"
      - .:$PWD
    ports:
      - 230:4000
    depends_on:
      - jaeger
    working_dir: $PWD
    environment:
      APP_NAME: MY_SERVICE_NAME
      VERSION: 0.0.0-dev
    env_file:
      - biscuit.env
```

## Configuration

### General

If you want to disable tracing via configuration (if you need to turn it off for a particular environment, for example) like so:

``` elixir
config :prima_opentelemetry_ex, :enabled, false
```

You can also disable the instrumentation for Ecto and/or Absinthe by setting the `exclude` key like in the following example:

```elixir
config :prima_opentelemetry_ex, exclude: [:ecto, :absinthe]
```

To configure the endpoint to send traces to, you can use the `:endpoint` configuration key to set protocol, host and port of the destination endpoint (agent or collector).
In this example you can see the default value for every configuration:

``` elixir
config :prima_opentelemetry_ex, :endpoint,
    protocol: :http,
    host: "jaeger",
    port: 55681
```

These values get used to build the configuration for the opentelemetry_exporter (through a batch processor). If you want to have a bit more freedom and set opentelemetry configuration by yourself feel free to do so, it won't get overwritten.
Example opentelemetry configuration:

``` elixir
config :opentelemetry, :processors,
  otel_batch_processor: %{
    exporter: {:opentelemetry_exporter, %{endpoints: [{:http, "jaeger", 55681, []}]}}
  }
```

### GraphQL

You can change the default span name and choose which informations about your graphql you want traced; e.g.

``` elixir
config :prima_opentelemetry_ex, :graphql,
    span_name: "graphql resolution",
    trace_request_variables: false
```

All the `:graphql` configurations get passed directly to `OpentelemetryAbsinthe`. For more informations about what you can do with them, see opentelemetry_absinthe [readme](https://github.com/primait/opentelemetry_absinthe#readme)

## Copyright and License

Copyright (c) 2020 Prima.it

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the [LICENSE.md](./LICENSE.md) file for more details.
