defmodule ExMatchers.GreaterOrEqualThan do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom
  import ExMatchers.Helpers

  defprotocol GreaterOrEqualThanMatcher do
    @fallback_to_any true
    
    def to_match(actual, another)
    def to_not_match(actual, another)
  end

  defimpl GreaterOrEqualThanMatcher, for: [Integer, Float] do
    
    match_logic(actual, expected) do
      actual >= expected
    end
  end

  defimpl GreaterOrEqualThanMatcher, for: Any do

    unsupported(actual, expected) do
      "Greater or equal than not supported between #{actual} and #{expected}"
    end
  end

  defmatcher be_greater_or_equal_than(another), matcher: GreaterOrEqualThanMatcher
end
