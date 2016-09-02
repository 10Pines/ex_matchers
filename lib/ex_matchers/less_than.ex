defmodule ExMatchers.LessThan do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom

  defprotocol LessThanMatcher do
    @fallback_to_any true
    def to_match(actual, another)
    def to_not_match(actual, another)
  end

  defimpl LessThanMatcher, for: [Integer, Float] do
    def to_match(actual, another) do
      assert actual < another
    end
    def to_not_match(actual, another) do
      refute actual < another
    end
  end

  defimpl LessThanMatcher, for: Any do
    def to_match(actual, another) do
      flunk "Less than not supported between #{actual} and #{another}"
    end
    def to_not_match(actual, another) do
      flunk "Less than not supported between #{actual} and #{another}"
    end
  end

  defmatcher be_less_than(another), matcher: LessThanMatcher
end
