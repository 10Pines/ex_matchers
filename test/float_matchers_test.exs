defmodule FloatMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers

  describe "a float" do
    setup do
      %{actual: 3.14}
    end

    test "is equal to another", %{actual: a_float} do
      expect a_float, to: eq(3.14)
    end

    test "is less than another", %{actual: a_float} do
      expect a_float, to: be_less_than(3.15)
    end

    test "is less or equal than another", %{actual: a_float} do
      expect a_float, to: be_less_or_equal_than(3.14)
      expect a_float, to: be_less_or_equal_than(3.15)
    end

    test "is greater than another", %{actual: a_float} do
      expect a_float, to: be_greater_than(3.13)
    end

    test "is greater or equal than another", %{actual: a_float} do
      expect a_float, to: be_greater_or_equal_than(3.14)
      expect a_float, to: be_greater_or_equal_than(3.13)
    end

    test "is not equal to another", %{actual: a_float} do
      expect a_float, to_not: eq(3.15)
    end

    test "is equal to another within a delta", %{actual: a_float} do
      expect a_float, to:     eq(3.13),
                      within: 0.011
    end

    test "is not equal to another within a delta", %{actual: a_float} do
      expect a_float, to_not: eq(3.12),
                      within: 0.01
    end

  end
end
