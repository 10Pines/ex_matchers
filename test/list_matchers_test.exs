defmodule ListMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers

  describe "a list" do
    setup do
      %{actual: [1, 2, 3, 4, 5]}
    end

    test "is equal to another", %{actual: a_list} do
      expect a_list, to: eq([1, 2, 3, 4, 5])
    end

    test "is not equal to another", %{actual: a_list} do
      expect a_list, to_not: eq([1, 2, 3, 5])
    end

    test "have items", %{actual: a_list} do
      expect a_list, to: have_items(5)
    end

    test "is not empty", %{actual: a_list} do
      expect a_list, to_not: be_empty
    end

    test "includes element", %{actual: a_list} do
      expect a_list, to: include(4)
    end

    test "does not include element", %{actual: a_list} do
      expect a_list, to_not: include(6)
    end
  end
end
