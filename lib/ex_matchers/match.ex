defmodule ExMatchers.Match do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom

  defprotocol MatchMatcher do
    @fallback_to_any true
    def to_match(actual, regex)
    def to_not_match(actual, regex)
  end

  defimpl MatchMatcher, for: BitString do
    def to_match(actual, regex) do
      assert Regex.match?(regex, actual)
    end
    def to_not_match(actual, regex) do
      refute Regex.match?(regex, actual)
    end
  end

  defimpl MatchMatcher, for: Any do
    def to_match(actual, regex) do
      flunk "Match not supported between #{actual} and #{regex}"
    end
    def to_not_match(actual, regex) do
      flunk "Match not supported between #{actual} and #{regex}"
    end
  end

  defmatcher match(regex), matcher: MatchMatcher

end
