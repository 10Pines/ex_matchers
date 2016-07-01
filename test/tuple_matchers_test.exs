defmodule TupleMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers

  describe "a tuple" do
    setup do
      %{actual: {:ok, "hello", 1}}
    end

    test "is equal to another", %{actual: a_tuple} do
      expect a_tuple, to: eq({:ok, "hello", 1})
    end

    test "is not equal to another", %{actual: a_tuple} do
      expect a_tuple, to_not: eq({:ok, "hello"})
    end

    test "have items", %{actual: a_tuple} do
      expect a_tuple, to: have_items(3)
    end

    test "is not empty", %{actual: a_tuple} do
      expect a_tuple, to_not: be_empty
    end

    test "includes element", %{actual: a_tuple} do
      expect a_tuple, to: include(:ok)
    end

    test "does not include element", %{actual: a_tuple} do
      expect a_tuple, to_not: include(:error)
    end
  end
end
