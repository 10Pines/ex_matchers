defmodule IsEmptyMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers

  describe "is empty" do
    test "a tuple" do
      expect {}, to: be_empty
    end

    test "a map" do
      expect %{}, to: be_empty
    end

    test "a string" do
      expect "", to: be_empty
    end

    test "fails when non-empty string" do
      assert_function = fn() -> expect "Hello", to: be_empty end
      expect assert_function, to: raise_error(ExUnit.AssertionError)
    end

    test "a list" do
      expect [], to: be_empty
    end
  end

  describe "nil" do
    test "is empty" do
      expect nil, to: be_empty
    end

    test "is not empty fails assertion" do
      assert_function = fn() -> expect nil, to_not: be_empty end
      expect assert_function, to: raise_error(ExUnit.AssertionError),
                            with: ~r/Nil is empty/
    end
  end
end
