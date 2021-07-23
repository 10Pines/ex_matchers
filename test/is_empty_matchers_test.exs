defmodule IsEmptyMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers
  import AssertHelpers

  describe "is empty" do
    test "a tuple" do
      expect {}, to: be_empty()
    end

    test "a map" do
      expect %{}, to: be_empty()
    end

    test "a string" do
      expect "", to: be_empty()
    end

    test "a list" do
      expect [], to: be_empty()
    end

    test "a map set" do
      expect MapSet.new(), to: be_empty()
    end
  end

  describe "is empty failed assertions" do
    test "a string" do
      expect_assertion_to_fail fn() -> expect "Hello", to: be_empty() end
    end

    test "a map" do
      expect_assertion_to_fail fn() -> expect %{a: 1}, to: be_empty() end
    end

    test "a list" do
      expect_assertion_to_fail fn() -> expect [1, 2], to: be_empty() end
    end

    test "a tuple" do
      expect_assertion_to_fail fn() -> expect {:ok, 1}, to: be_empty() end
    end
  end

  describe "nil" do
    test "is empty" do
      expect nil, to: be_empty()
    end

    test "is not empty fails assertion" do
      expect_assertion_to_fail fn() -> expect nil, to_not: be_empty() end
    end
  end
end
