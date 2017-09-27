defmodule ExMatchers.Helpers do
    
    defmacro match_logic(actual, expected, do: logic) do
        quote do
            def to_match(actual_value, expected_value) do
                var!(unquote(actual)) = actual_value
                var!(unquote(expected)) = expected_value
                assert unquote(logic)
            end

            def to_not_match(actual_value, expected_value) do
                var!(unquote(actual)) = actual_value
                var!(unquote(expected)) = expected_value
                refute unquote(logic)
            end
        end
    end

    defmacro unsupported(actual, expected, do: logic) do
        quote do
            def to_match(actual_value, expected_value) do
                var!(unquote(actual)) = actual_value
                var!(unquote(expected)) = expected_value
                flunk unquote(logic)
            end

            def to_not_match(actual_value, expected_value) do
                var!(unquote(actual)) = actual_value
                var!(unquote(expected)) = expected_value
                flunk unquote(logic)
            end
        end
    end
end
