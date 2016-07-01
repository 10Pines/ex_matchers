defmodule ExMatchers.StartsWith do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom

  defprotocol StartsWithMatcher do
    @fallback_to_any true
    def to_match(actual, another)
    def to_not_match(actual, another)
  end

  defimpl StartsWithMatcher, for: BitString do
    def to_match(actual, substring) do
      assert String.starts_with?(actual, substring)
    end
    def to_not_match(actual, substring) do
      refute String.starts_with?(actual, substring)
    end
  end

  defimpl StartsWithMatcher, for: Any do
    def to_match(actual, another) do
      flunk "Starts with not supported between #{actual} and #{another}"
    end
    def to_not_match(actual, another) do
      flunk "Starts with not supported between #{actual} and #{another}"
    end
  end

  defmatcher start_with(substring), with: StartsWithMatcher

end