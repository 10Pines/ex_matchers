defmodule ExMatchers.StartWith do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom

  defprotocol StartWithMatcher do
    @fallback_to_any true
    def to_match(actual, another)
    def to_not_match(actual, another)
  end

  defimpl StartWithMatcher, for: BitString do
    def to_match(actual, substring) do
      assert String.starts_with?(actual, substring)
    end
    def to_not_match(actual, substring) do
      refute String.starts_with?(actual, substring)
    end
  end

  defimpl StartWithMatcher, for: List do
    def to_match(actual, element) do
      assert List.first(actual) == element
    end
    def to_not_match(actual, element) do
      refute List.first(actual) == element
    end
  end

  defimpl StartWithMatcher, for: Range do
    def to_match(actual, element) do
      assert Enum.at(actual, 0) == element
    end
    def to_not_match(actual, element) do
      refute Enum.at(actual, 0) == element
    end
  end

  defimpl StartWithMatcher, for: Any do
    def to_match(actual, another) do
      flunk "Starts with not supported between #{actual} and #{another}"
    end
    def to_not_match(actual, another) do
      flunk "Starts with not supported between #{actual} and #{another}"
    end
  end

  defmatcher start_with(substring), matcher: StartWithMatcher

end
