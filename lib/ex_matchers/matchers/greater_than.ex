defmodule ExMatchers.GreaterThan do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom
  import ExMatchers.Helpers

  defprotocol GreaterThanMatcher do
    @fallback_to_any true

    def to_match(actual, another)
    def to_not_match(actual, another)
  end

  defimpl GreaterThanMatcher, for: [Integer, Float] do
    
    match_logic(actual, expected) do
      actual > expected
    end
  end

  defimpl GreaterThanMatcher, for: Any do
    
    unsupported(actual, expected) do
      "Greater than not supported between #{actual} and #{expected}"
    end
  end

  defmatcher be_greater_than(another), matcher: GreaterThanMatcher
end
