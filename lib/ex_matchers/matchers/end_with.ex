defmodule ExMatchers.EndWith do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom
  import ExMatchers.Helpers

  defprotocol EndWithMatcher do
    @fallback_to_any true

    def to_match(actual, another)
    def to_not_match(actual, another)
  end

  defimpl EndWithMatcher, for: BitString do

    match_logic(actual, substring) do
      String.ends_with?(actual, substring)
    end
  end

  defimpl EndWithMatcher, for: List do

    match_logic(list, element) do
      List.last(list) == element
    end
  end

  defimpl EndWithMatcher, for: Range do

    match_logic(actual, expected) do
      _first..last = actual
      last == expected
    end
  end

  defimpl EndWithMatcher, for: Any do

    unsupported(actual, expected) do
      "Ends with not supported between #{actual} and #{expected}"
    end
  end

  defmatcher end_with(substring), matcher: EndWithMatcher

end
