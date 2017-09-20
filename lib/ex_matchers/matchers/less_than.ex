defmodule ExMatchers.LessThan do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom
  import ExMatchers.Helpers

  defprotocol LessThanMatcher do
    @fallback_to_any true

    def to_match(actual, another)
    def to_not_match(actual, another)
  end

  defimpl LessThanMatcher, for: [Integer, Float] do
    
    match_logic(actual, expected) do
      actual < expected  
    end
  end

  defimpl LessThanMatcher, for: Any do

    unsupported(actual, expected) do
      "Less than not supported between #{actual} and #{expected}"
    end
  end

  defmatcher be_less_than(another), matcher: LessThanMatcher
end
