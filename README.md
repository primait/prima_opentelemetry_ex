# PrimaOpentelemetryEx

This is your one-stop source of all things opentelemetry in elixir.
You can stop getting headaches figuring out which opentelemetry_beam library you need or resolving dependencies conflicts.
Just add
```elixir
    {:prima_opentelemetry_ex, git: "git@github.com:primait/prima_opentelemetry_ex.git"}
```
to your dependencies and you are good to go.

What's covered:
- Absinthe

## Configuration

### GraphQL

You can change the default span name and choose which informations about your graphql you want traced; e.g.

``` elixir
config :prima_opentelemetry_ex, :graphql,
    span_name: "graphql resolution",
    trace_request_variables: false
```
All the `:graphql` configurations get passed directly to `OpentelemetryAbsinthe`. For more informations about what you can do with them, see https://github.com/primait/opentelemetry_absinthe#readme
