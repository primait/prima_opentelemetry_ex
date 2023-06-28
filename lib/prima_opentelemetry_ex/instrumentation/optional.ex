defmodule PrimaOpentelemetryEx.Instrumentation.Optional do
  @moduledoc false

  @doc """
    Creates a maybe_setup function that instruments a library using an optional instrumentation library.
    
    Executes the `do` block if:
      * `to_instrument` is available
      * `instrumenting_library` is available
      * `feature_name` is not in the prima_opentelemetry_ex exclude list
    
    * `to_instrument`: the module that will be instrumented(eg. `Ecto`)
    * `instrumenting_library`: the module that will be used to instrument(eg. `OpentelemetryEcto`)
    * `feature_name`: atom specifing the name of the feature. Typically the name of the to_instrument library in atom format(eg. `:ecto`)
  """
  defmacro create(
             [
               to_instrument: to_instrument,
               instrumenting_library: instrumenting_library,
               feature_name: feature_name
             ],
             do: setup_instrumentation
           ) do
    quote do
      cond do
        # First check if the feature is enabled on compile time
        not PrimaOpentelemetryEx.enabled?(unquote(feature_name)) ->
          def maybe_setup, do: nil

        Code.ensure_loaded?(unquote(instrumenting_library)) ->
          def maybe_setup do

            # Runtime check to make sure the feature is enabled on runtime time
            if PrimaOpentelemetryEx.enabled?(unquote(feature_name)) do
              unquote(setup_instrumentation)
              nil
            end
          end

        Code.ensure_loaded?(unquote(to_instrument)) ->
          raise """
          #{unquote(to_instrument)} has been loaded without installing the optional #{unquote(instrumenting_library)} dependency.
          PrimaOpentelemetryEx will not be able to instrument absinthe unless you add it.

          Note: you can get rid of this warning by excluding absinthe from instrumentation with `config :prima_opentelemetry_ex, exclude: [:#{unquote(feature_name)}]`
          """

        true ->
          def maybe_setup, do: nil
      end
    end
  end
end
