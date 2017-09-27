defmodule ExMatchers.Size do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom
  import ExMatchers.Helpers

  defprotocol SizeMatcher do
    @fallback_to_any true

    def to_match(value)
    def to_match(value, size)
    def to_not_match(value)
    def to_not_match(value, size)
  end

  defimpl SizeMatcher, for: Map do
    
    match_logic(map, size) do
      map_size(map) == size
    end
    
    def to_match(value) do
      to_match(value, 0)
    end

    def to_not_match(value) do
      to_not_match(value, 0)
    end
  end

  defimpl SizeMatcher, for: Tuple do

    match_logic(tuple, size) do
      tuple_size(tuple) == size
    end

    def to_match(value) do
      to_match(value, 0)
    end

    def to_not_match(value) do
      to_not_match(value, 0)
    end
  end

  defimpl SizeMatcher, for: BitString do
    
    match_logic(string, size) do
      byte_size(String.trim(string)) == size
    end

    def to_match(value) do
      to_match(value, 0)
    end

    def to_not_match(value) do
      to_not_match(value, 0)
    end
  end

  defimpl SizeMatcher, for: List do
    
    match_logic(list, size) do
      length(list) == size  
    end

    def to_match(value) do
      to_match(value, 0)
    end
    
    def to_not_match(value) do
      to_not_match(value, 0)
    end
  end

  defimpl SizeMatcher, for: Range do

    match_logic(range, size) do
      Enum.count(range) == size
    end

    def to_match(value) do
      to_match(value, 0)
    end

    def to_not_match(value) do
      to_not_match(value, 0)
    end
  end

  defimpl SizeMatcher, for: Atom do
    
    def to_match(nil), do: true
    def to_match(nil, _size), do: true
    def to_not_match(nil), do: flunk "Nil is empty"
    def to_not_match(nil, _size), do: flunk "Nil is empty"
  end

  defimpl SizeMatcher, for: Any do
    
    
    unsupported(value, size) do
      "Size not supported for #{value} with size #{size}"
    end
    
    def to_match(value) do
      flunk "Size not supported for #{value}"
    end

    def to_not_match(value) do
      flunk "Size not supported for #{value}"
    end
  end

  defmatcher be_empty,           matcher: SizeMatcher
  defmatcher have_items(number), matcher: SizeMatcher

end
