defmodule ExceptionMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers

  describe "a function" do
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
end
