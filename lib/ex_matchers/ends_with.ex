defmodule ExMatchers.EndsWith do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom

  defprotocol EndsWithMatcher do
    @fallback_to_any true
    def to_match(actual, another)
    def to_not_match(actual, another)
  end

  defimpl EndsWithMatcher, for: BitString do
    def to_match(actual, substring) do
      assert String.ends_with?(actual, substring)
    end
    def to_not_match(actual, substring) do
      refute String.ends_with?(actual, substring)
    end
  end

  defimpl EndsWithMatcher, for: Any do
    def to_match(actual, another) do
      flunk "Ends with not supported between #{actual} and #{another}"
    end
    def to_not_match(actual, another) do
      flunk "Ends with not supported between #{actual} and #{another}"
    end
  end

  defmatcher end_with(substring), with: EndsWithMatcher

end