defmodule ExMatchers.Custom do
  @moduledoc false

  defmacro defmatcher(definition={_,_,nil}, matcher: matcher_module) do
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

  defmacro defmatcher(definition={_,_,args}, matcher: matcher_module) do
    quote do
      def unquote(definition) do
        fn(actual, assertion) ->
          case assertion do
            :assert -> unquote(matcher_module).to_match(actual, unquote_splicing(args))
            :refute -> unquote(matcher_module).to_not_match(actual, unquote_splicing(args))
          end
        end
      end
    end
  end

  defmacro defmatcher(definition={_,_,args}, with: _, matcher: matcher_module) do
    quote do
      def unquote(definition) do
        fn(actual, assertion) ->
          case assertion do
            :assert -> unquote(matcher_module).to_match(actual, unquote_splicing(args))
            :refute -> unquote(matcher_module).to_not_match(actual, unquote_splicing(args))
            {:assert, extra} -> unquote(matcher_module).to_match(actual, unquote_splicing(args), extra)
            {:refute, extra} -> unquote(matcher_module).to_not_match(actual, unquote_splicing(args), extra)
          end
        end
      end
    end
  end
end
