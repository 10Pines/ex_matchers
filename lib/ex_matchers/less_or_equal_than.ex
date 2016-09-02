defmodule ExMatchers.LessOrEqualThan do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom

  defprotocol LessOrEqualThanMatcher do
    @fallback_to_any true
    def to_match(actual, another)
    def to_not_match(actual, another)
  end

  defimpl LessOrEqualThanMatcher, for: [Integer, Float] do
    def to_match(actual, another) do
      assert actual <= another
    end
    def to_not_match(actual, another) do
      refute actual <= another
    end
  end

  defimpl LessOrEqualThanMatcher, for: Any do
    def to_match(actual, another) do
      flunk "Less or equal than not supported between #{actual} and #{another}"
    end
    def to_not_match(actual, another) do
      flunk "Less or equal than not supported between #{actual} and #{another}"
    end
  end

  defmatcher be_less_or_equal_than(another), matcher: LessOrEqualThanMatcher
end
