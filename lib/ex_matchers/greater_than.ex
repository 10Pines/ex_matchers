defmodule ExMatchers.GreaterThan do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom

  defprotocol GreaterThanMatcher do
    @fallback_to_any true
    def to_match(actual, another)
    def to_not_match(actual, another)
  end

  defimpl GreaterThanMatcher, for: [Integer, Float] do
    def to_match(actual, another) do
      assert actual > another
    end
    def to_not_match(actual, another) do
      refute actual > another
    end
  end

  defimpl GreaterThanMatcher, for: Any do
    def to_match(actual, another) do
      flunk "Greater than not supported between #{actual} and #{another}"
    end
    def to_not_match(actual, another) do
      flunk "Greater than not supported between #{actual} and #{another}"
    end
  end

  defmatcher be_greater_than(another), with: GreaterThanMatcher
end