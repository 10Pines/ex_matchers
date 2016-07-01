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

    test "a list" do
      expect [], to: be_empty
    end
  end

  describe "nil" do
    test "is empty" do
      expect nil, to: be_empty
    end

    test "is not empty fails assertion" do
      try do
        expect nil, to_not: be_empty
        flunk "Not nil assertion did not fail"
       rescue
        e in ExUnit.AssertionError -> assert e.message == "Nil is empty"
      end
    end
  end
end
