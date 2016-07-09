defmodule ExMatchers.Equal do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom

  defprotocol EqualMatcher do
    @fallback_to_any true
    def to_match(actual, another)
    def to_match(actual, another, delta)
    def to_not_match(actual, another)
    def to_not_match(actual, another, delta)
  end

  defimpl EqualMatcher, for: Float do
    def to_match(actual, another) do
      assert actual == another
    end
    def to_match(actual, another, delta) do
      assert_in_delta actual, another, delta
    end
    def to_not_match(actual, another) do
      refute actual == another
    end
    def to_not_match(actual, another, delta) do
      refute_in_delta actual, another, delta
    end
  end

  defimpl EqualMatcher, for: Any do
    def to_match(actual, another) do
      assert actual == another
    end
    def to_match(actual, another, delta) do
      flunk "Equal within delta not supported between #{actual} and #{another} within #{delta}"
    end
    def to_not_match(actual, another) do
      refute actual == another
    end
    def to_not_match(actual, another, delta) do
      flunk "Equal within delta not supported between #{actual} and #{another} within #{delta}"
    end
  end

  defmatcher eq(another), with: EqualMatcher
end