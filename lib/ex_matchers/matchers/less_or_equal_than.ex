defmodule ExMatchers.LessOrEqualThan do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom
  import ExMatchers.Helpers

  defprotocol LessOrEqualThanMatcher do
    @fallback_to_any true

    def to_match(actual, another)
    def to_not_match(actual, another)
  end

  defimpl LessOrEqualThanMatcher, for: [Integer, Float] do

    match_logic(actual, expected) do
      actual <= expected
    end
  end

  defimpl LessOrEqualThanMatcher, for: Any do
    
    unsupported(actual, expected) do
      "Less or equal than not supported between #{actual} and #{expected}"
    end
  end

  defmatcher be_less_or_equal_than(another), matcher: LessOrEqualThanMatcher
end
