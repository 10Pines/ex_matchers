defmodule ExMatchers.Include do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom
  import ExMatchers.Helpers

  defprotocol IncludeMatcher do

    def to_match(value, key)
    def to_match(value, key, expected_value)
    def to_not_match(value, key)
    def to_not_match(value, key, expected_value)
  end

  defimpl IncludeMatcher, for: BitString do

    match_logic(actual, substring) do
      String.contains?(actual, substring)
    end
  
    def to_match(value, substring, expected_value) do
      flunk "Includes not supported from #{substring} in #{value} with #{expected_value}"
    end

    def to_not_match(value, substring, expected_value) do
      flunk "Includes not supported from #{substring} in #{value} with #{expected_value}"
    end
  end

  defimpl IncludeMatcher, for: List do
    
    match_logic(list, element) do
      Enum.member?(list, element)
    end

    def to_match(list, element, expected_value) do
      flunk "Includes not supported from #{element} in #{list} with #{expected_value}"
    end

    def to_not_match(list, element, expected_value) do
      flunk "Includes not supported from #{element} in #{list} with #{expected_value}"
    end
  end

  defimpl IncludeMatcher, for: Range do

    match_logic(range, element) do
      Enum.member?(range, element)
    end
    
    def to_match(range, element, expected_value) do
      flunk "Includes not supported from #{element} in #{range} with #{expected_value}"
    end
    
    def to_not_match(range, element, expected_value) do
      flunk "Includes not supported from #{element} in #{range} with #{expected_value}"
    end
  end

  defimpl IncludeMatcher, for: Tuple do

    match_logic(tuple, element) do
      Tuple.to_list(tuple) |> Enum.member?(element)
    end

    def to_match(tuple, element, expected_value) do
      flunk "Includes not supported from #{element} in #{tuple} with #{expected_value}"
    end

    def to_not_match(tuple, element, expected_value) do
      flunk "Includes not supported from #{element} in #{tuple} with #{expected_value}"
    end
  end

  defimpl IncludeMatcher, for: Map do

    match_logic(map, key) do
      Map.has_key?(map, key)
    end

    def to_match(value, keys, expected_value) when is_list(keys) do
      assert get_in(value, keys) == expected_value
    end

    def to_match(value, key, expected_value) do
      assert value[key] == expected_value
    end

    def to_not_match(value, keys, expected_value) when is_list(keys) do
      refute get_in(value, keys) == expected_value
    end

    def to_not_match(value, key, expected_value) do
      refute value[key] == expected_value
    end
  end

  defmatcher include(key), with: value, matcher: IncludeMatcher
end
