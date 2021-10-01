# PrimaOpentelemetryEx

This is your one-stop source of all things opentelemetry in elixir.
You can stop getting headaches figuring out which opentelemetry_beam library you need or resolving dependencies conflicts.
Just add

```elixir
    {:prima_opentelemetry_ex, git: "git@github.com:primait/prima_opentelemetry_ex.git"}
```

to your dependencies and you are good to go.

What's covered:
- HTTPoison - to trace the http calls you make to external system and to pass along the trace context
- Plug - to link your phoenix/plug handled requests with client spans as parents
- Absinthe - to trace your GraphQL resolutions in a single span
- Ecto - to trace your database transactions in a single span


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

For more informations see [telepoison usage](https://github.com/primait/telepoison#usage)

To emit server spans (from plug) you need to add `Teleplug` to your plug pipeline either in your phoenix endpoint module or in every pipeline you want to trace (contained in your router module if you are using phoenix).
e.g.

``` elixir
pipeline :example do
    plug Teleplug
    plug Plug.Logger
end
```

GraphQL and database spans are emitted automatically.


## Configuration

### General

If you want to disable tracing via configuration (if you need to turn it off for a particular environment, for example) like so:

``` elixir
config :prima_opentelemetry_ex, :enabled, false
```

To configure the endpoint to send traces to, you can use the `:endpoint` configuration key to set, protocol, host and port of the destination endpoint (agent or collector).
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
All the `:graphql` configurations get passed directly to `OpentelemetryAbsinthe`. For more informations about what you can do with them, see [opentelemetry_absinthe readme](https://github.com/primait/opentelemetry_absinthe#readme)

