# PrimaOpentelemetryEx

This is your one-stop source of all things opentelemetry in elixir.
You can stop getting headaches figuring out which opentelemetry_beam library you need or resolving dependencies conflicts.
Just add

```elixir
    {:prima_opentelemetry_ex, git: "git@github.com:primait/prima_opentelemetry_ex.git"}
```

to your dependencies and you are good to go.

What's covered:
- Plug - to link your phoenix/plug handled requests with client spans as parents
- Absinthe - to trace your GraphQL resolutions in a single span


## Usage

To start collecting traces just put

``` elixir
PrimaOpentelemetryEx.setup()
```
in your application start function.
To actually emit server spans (from plug) you need to add `Teleplug` to your plug pipeline either in your phoenix endpoint module or in every pipeline you want to trace (contained in your router module if you are using phoenix).

e.g.

``` elixir
pipeline :example do
    plug Teleplug
    plug Plug.Logger
end
```

GraphQL spans are emitted automatically.


## Configuration

### General

If you want to disable tracing via configuration (if you need to turn it off for a particular environment, for example) like so:

``` elixir
config :prima_opentelemetry_ex, :enabled, false
```

### GraphQL

You can change the default span name and choose which informations about your graphql you want traced; e.g.

``` elixir
config :prima_opentelemetry_ex, :graphql,
    span_name: "graphql resolution",
    trace_request_variables: false
```
All the `:graphql` configurations get passed directly to `OpentelemetryAbsinthe`. For more informations about what you can do with them, see https://github.com/primait/opentelemetry_absinthe#readme
