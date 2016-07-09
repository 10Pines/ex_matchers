defmodule ExMatchers.EndWith do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom

  defprotocol EndWithMatcher do
    @fallback_to_any true
    def to_match(actual, another)
    def to_not_match(actual, another)
  end

  defimpl EndWithMatcher, for: BitString do
    def to_match(actual, substring) do
      assert String.ends_with?(actual, substring)
    end
    def to_not_match(actual, substring) do
      refute String.ends_with?(actual, substring)
    end
  end

  defimpl EndWithMatcher, for: Any do
    def to_match(actual, another) do
      flunk "Ends with not supported between #{actual} and #{another}"
    end
    def to_not_match(actual, another) do
      flunk "Ends with not supported between #{actual} and #{another}"
    end
  end

  defmatcher end_with(substring), with: EndWithMatcher

end