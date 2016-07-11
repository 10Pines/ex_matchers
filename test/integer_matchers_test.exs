defmodule IntegerMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers
  import AssertHelpers

  describe "an integer" do
    setup do
      %{actual: 42}
    end

    test "is equal to another", %{actual: a_integer} do
      expect a_integer, to: eq(42)
    end

    test "is less than another", %{actual: a_integer} do
      expect a_integer, to: be_less_than(43)
    end

    test "is less or equal than another", %{actual: a_integer} do
      expect a_integer, to: be_less_or_equal_than(42)
      expect a_integer, to: be_less_or_equal_than(43)
    end

    test "is greater than another", %{actual: a_integer} do
      expect a_integer, to: be_greater_than(41)
    end

    test "is greater or equal than another", %{actual: a_integer} do
      expect a_integer, to: be_greater_or_equal_than(42)
      expect a_integer, to: be_greater_or_equal_than(41)
    end

    test "is not equal to another", %{actual: a_integer} do
      expect a_integer, to_not: eq(41)
    end
  end

  describe "an integer failed assertions" do
    setup do
      %{actual: 42}
    end

    test "is equal to another", %{actual: a_integer} do
      expect_assertion_to_fail fn() -> expect a_integer, to: eq(41) end
    end

    test "is less than another", %{actual: a_integer} do
      expect_assertion_to_fail fn() ->  expect a_integer, to: be_less_than(41) end
    end

    test "is less or equal than another", %{actual: a_integer} do
      expect_assertion_to_fail fn() -> expect a_integer, to: be_less_or_equal_than(41) end
    end

    test "is greater than another", %{actual: a_integer} do
      expect_assertion_to_fail fn() -> expect a_integer, to: be_greater_than(43) end
    end

    test "is greater or equal than another", %{actual: a_integer} do
      expect_assertion_to_fail fn() ->  expect a_integer, to: be_greater_or_equal_than(43) end
    end

    test "is not equal to another", %{actual: a_integer} do
      expect_assertion_to_fail fn() -> expect a_integer, to_not: eq(42) end
    end
  end
end
