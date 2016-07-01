defmodule ExMatchers.Include do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom

  defprotocol IncludeMatcher do
    def to_match(value, key)
    def to_match(value, key, expected_value)
    def to_not_match(value, key)
    def to_not_match(value, key, expected_value)
  end

  defimpl IncludeMatcher, for: BitString do
    def to_match(value, substring) do
      assert String.contains?(value, substring)
    end
    def to_match(value, substring, expected_value) do
      flunk "Includes not supported from #{substring} in #{value} with #{expected_value}"
    end
    def to_not_match(value, substring) do
      refute String.contains?(value, substring)
    end
    def to_not_match(value, substring, expected_value) do
      flunk "Includes not supported from #{substring} in #{value} with #{expected_value}"
    end
  end

  defimpl IncludeMatcher, for: List do
    def to_match(list, element) do
      assert Enum.member?(list, element)
    end
    def to_match(list, element, expected_value) do
      flunk "Includes not supported from #{element} in #{list} with #{expected_value}"
    end
    def to_not_match(list, element) do
      refute Enum.member?(list, element)
    end
    def to_not_match(list, element, expected_value) do
      flunk "Includes not supported from #{element} in #{list} with #{expected_value}"
    end
  end

  defimpl IncludeMatcher, for: Tuple do
    def to_match(tuple, element) do
      assert Tuple.to_list(tuple) |> Enum.member?(element)
    end
    def to_match(tuple, element, expected_value) do
      flunk "Includes not supported from #{element} in #{tuple} with #{expected_value}"
    end
    def to_not_match(tuple, element) do
      refute Tuple.to_list(tuple) |> Enum.member?(element)
    end
    def to_not_match(tuple, element, expected_value) do
      flunk "Includes not supported from #{element} in #{tuple} with #{expected_value}"
    end
  end

  defimpl IncludeMatcher, for: Map do
    def to_match(value, key) do
      assert Map.has_key?(value, key)
    end

    def to_match(value, keys, expected_value) when is_list(keys) do
      assert get_in(value, keys) == expected_value
    end

    def to_match(value, key, expected_value) do
      assert value[key] == expected_value
    end

    def to_not_match(value, key) do
      refute Map.has_key?(value, key)
    end

    def to_not_match(value, keys, expected_value) when is_list(keys) do
      refute get_in(value, keys) == expected_value
    end

    def to_not_match(value, key, expected_value) do
      refute value[key] == expected_value
    end
  end

  defmatcher include(key), with: IncludeMatcher
end