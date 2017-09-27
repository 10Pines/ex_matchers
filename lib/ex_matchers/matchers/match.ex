defmodule ExMatchers.Match do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom
  import ExMatchers.Helpers

  defprotocol MatchMatcher do
    @fallback_to_any true

    def to_match(actual, regex)
    def to_not_match(actual, regex)
  end

  defimpl MatchMatcher, for: BitString do

    match_logic(actual, regex) do
      Regex.match?(regex, actual)
    end
  end

  defimpl MatchMatcher, for: Any do
    
    unsupported(actual, regex) do
      "Match not supported between #{actual} and #{regex}"
    end
  end

  defmatcher match(regex), matcher: MatchMatcher

end
