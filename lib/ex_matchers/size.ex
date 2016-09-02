defmodule ExMatchers.Size do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom

  defprotocol SizeMatcher do
    @fallback_to_any true
    def to_match(value)
    def to_match(value, size)
    def to_not_match(value)
    def to_not_match(value, size)
  end

  defimpl SizeMatcher, for: Map do
    def to_match(value) do
      to_match(value, 0)
    end
    def to_match(value, size) do
      assert map_size(value) == size
    end
    def to_not_match(value) do
      to_not_match(value, 0)
    end
    def to_not_match(value, size) do
      refute map_size(value) == size
    end
  end

  defimpl SizeMatcher, for: Tuple do
    def to_match(value) do
      to_match(value, 0)
    end
    def to_match(value, size) do
      assert tuple_size(value) == size
    end
    def to_not_match(value) do
      to_not_match(value, 0)
    end
    def to_not_match(value, size) do
      refute tuple_size(value) == size
    end
  end

  defimpl SizeMatcher, for: BitString do
    def to_match(value) do
      to_match(value, 0)
    end
    def to_match(value, size) do
      assert byte_size(String.strip(value)) == size
    end
    def to_not_match(value) do
      to_not_match(value, 0)
    end
    def to_not_match(value, size) do
      refute byte_size(String.strip(value)) == size
    end
  end

  defimpl SizeMatcher, for: List do
    def to_match(value) do
      to_match(value, 0)
    end
    def to_match(value, size) do
      assert length(value) == size
    end
    def to_not_match(value) do
      to_not_match(value, 0)
    end
    def to_not_match(value, size) do
      refute length(value) == size
    end
  end

  defimpl SizeMatcher, for: Range do
    def to_match(value) do
      to_match(value, 0)
    end
    def to_match(value, size) do
      assert Enum.count(value) == size
    end
    def to_not_match(value) do
      to_not_match(value, 0)
    end
    def to_not_match(value, size) do
      refute Enum.count(value) == size
    end
  end

  defimpl SizeMatcher, for: Atom do
    def to_match(nil), do: true
    def to_match(nil, _size), do: true
    def to_not_match(nil), do: flunk "Nil is empty"
    def to_not_match(nil, _size), do: flunk "Nil is empty"
  end

  defimpl SizeMatcher, for: Any do
    def to_match(value) do
      flunk "Size not supported for #{value}"
    end
    def to_match(value, size) do
      flunk "Size not supported for #{value} with size #{size}"
    end
    def to_not_match(value) do
      flunk "Size not supported for #{value}"
    end
    def to_not_match(value, size) do
      flunk "Size not supported for #{value} with size #{size}"
    end
  end

  defmatcher be_empty,           matcher: SizeMatcher
  defmatcher have_items(number), matcher: SizeMatcher

end
