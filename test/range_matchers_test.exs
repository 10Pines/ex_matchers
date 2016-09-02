defmodule RangeMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers
  import AssertHelpers

  describe "a range" do
    setup do
      %{actual: 1..10}
    end

    test "is equal to another", %{actual: a_range} do
      expect a_range, to: eq(1..10)
    end

    test "is not equal to another", %{actual: a_range} do
      expect a_range, to_not: eq(1..5)
    end

    test "have items", %{actual: a_range} do
      expect a_range, to: have_items(10)
    end

    test "includes element", %{actual: a_range} do
      expect a_range, to: include(5)
    end

    test "does not include element", %{actual: a_range} do
      expect a_range, to_not: include(11)
    end

    test "starts with element", %{actual: a_range} do
      expect a_range, to: start_with(1)
    end

    test "does not start with element", %{actual: a_range} do
      expect a_range, to_not: start_with(2)
    end

    test "ends with element", %{actual: a_range} do
      expect a_range, to: end_with(10)
    end

    test "does not end with element", %{actual: a_range} do
      expect a_range, to_not: end_with(11)
    end
  end

  describe "a range failed assertions" do
    setup do
      %{actual: 1..10}
    end

    test "is equal to another", %{actual: a_range} do
      expect_assertion_to_fail fn() -> expect  a_range, to: eq(1..5) end
    end

    test "is not equal to another", %{actual: a_range} do
      expect_assertion_to_fail fn() -> expect  a_range, to_not: eq(1..10) end
    end

    test "have items", %{actual: a_range} do
      expect_assertion_to_fail fn() -> expect  a_range, to: have_items(5) end
    end

    test "includes element", %{actual: a_range} do
      expect_assertion_to_fail fn() -> expect  a_range, to: include(11) end
    end

    test "does not include element", %{actual: a_range} do
      expect_assertion_to_fail fn() -> expect  a_range, to_not: include(5) end
    end

    test "starts with element", %{actual: a_range} do
      expect_assertion_to_fail fn() -> expect  a_range, to: start_with(2) end
    end

    test "does not start with element", %{actual: a_range} do
      expect_assertion_to_fail fn() -> expect  a_range, to_not: start_with(1) end
    end

    test "ends with element", %{actual: a_range} do
      expect_assertion_to_fail fn() -> expect  a_range, to: end_with(11) end
    end

    test "does not end with element", %{actual: a_range} do
      expect_assertion_to_fail fn() -> expect  a_range, to_not: end_with(10) end
    end

  end
end
