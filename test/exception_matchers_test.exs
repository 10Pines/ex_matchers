defmodule ExceptionMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers

  describe "a function that fails" do
    setup do
      %{actual: fn() -> raise ArgumentError, message: "invalid argument foo" end}
    end

    test "raise an error", %{actual: a_function} do
      expect a_function, to: raise_error(ArgumentError)
    end

    test "raise an error with message", %{actual: a_function} do
      expect a_function, to:   raise_error(ArgumentError),
                         with: "invalid argument foo"
    end
  end

  describe "a function that does not fail" do
    setup do
      %{actual: fn() -> true end}
    end

    test "does not raise an error", %{actual: a_function} do
      expect_function = fn() -> expect a_function, to: raise_error(ArgumentError) end
      assert_raise ExUnit.AssertionError, ~r/Expected exception ArgumentError but nothing was raised/, expect_function
    end

    test "does not raise an error with message", %{actual: a_function} do
      expect_function = fn() ->
        expect a_function, to: raise_error(ArgumentError),
                         with: "invalid argument foo"
      end
      assert_raise ExUnit.AssertionError, ~r/Expected exception ArgumentError but nothing was raised/, expect_function
    end
  end
end
