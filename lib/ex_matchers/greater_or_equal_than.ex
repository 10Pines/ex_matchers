defmodule ExMatchers.GreaterOrEqualThan do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom

  defprotocol GreaterOrEqualThanMatcher do
    @fallback_to_any true
    def to_match(actual, another)
    def to_not_match(actual, another)
  end

  defimpl GreaterOrEqualThanMatcher, for: [Integer, Float] do
    def to_match(actual, another) do
      assert actual >= another
    end
    def to_not_match(actual, another) do
      refute actual >= another
    end
  end

  defimpl GreaterOrEqualThanMatcher, for: Any do
    def to_match(actual, another) do
      flunk "Greater or equal than not supported between #{actual} and #{another}"
    end
    def to_not_match(actual, another) do
      flunk "Greater or equal than not supported between #{actual} and #{another}"
    end
  end

  defmatcher be_greater_or_equal_than(another), with: GreaterOrEqualThanMatcher
end