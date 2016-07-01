defmodule ExMatchers.Custom do
  @moduledoc false

  defmacro defmatcher(definition={_,_,nil}, with: matcher_module) do
    quote do
      def unquote(definition) do
        fn(actual, assertion) ->
          case assertion do
            :assert -> unquote(matcher_module).to_match(actual)
            :refute -> unquote(matcher_module).to_not_match(actual)
          end
        end
      end
    end
  end

  defmacro defmatcher(definition={name,_,args}, with: matcher_module) do
    expected = args |> hd |> Tuple.to_list |> hd
    quote do
      def unquote(name)(expected) do
        fn(actual, assertion) ->
          case assertion do
            :assert -> unquote(matcher_module).to_match(actual, expected)
            :refute -> unquote(matcher_module).to_not_match(actual, expected)
            {:assert, extra} -> unquote(matcher_module).to_match(actual, expected, extra)
            {:refute, extra} -> unquote(matcher_module).to_not_match(actual, expected, extra)
          end
        end
      end
    end
  end
end