defmodule ExMatchers.StartWith do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom
  import ExMatchers.Helpers

  defprotocol StartWithMatcher do
    @fallback_to_any true

    def to_match(actual, another)
    def to_not_match(actual, another)
  end

  defimpl StartWithMatcher, for: BitString do
    
    match_logic(actual, substring) do
      String.starts_with?(actual, substring)
    end
  end

  defimpl StartWithMatcher, for: List do

    match_logic(list, element) do
      List.first(list) == element
    end
  end

  defimpl StartWithMatcher, for: Range do
    
    match_logic(range, element) do
      Enum.at(range, 0) == element
    end
  end

  defimpl StartWithMatcher, for: Any do
    unsupported(actual, another) do
      "Starts with not supported between #{actual} and #{another}"
    end
  end

  defmatcher start_with(substring), matcher: StartWithMatcher

end
