defmodule StringMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers
  import AssertHelpers

  describe "a string" do
    setup do
      %{actual: "Hello Elixir"}
    end

    test "is equal to another", %{actual: a_string} do
      expect a_string, to: eq("Hello Elixir")
    end

    test "is not equal to another", %{actual: a_string} do
      expect a_string, to_not: eq("Hello Clojure")
    end

    test "have items", %{actual: a_string} do
      expect a_string, to: have_items(12)
    end

    test "is not empty", %{actual: a_string} do
      expect a_string, to_not: be_empty()
    end

    test "includes substring", %{actual: a_string} do
      expect a_string, to: include("Elix")
    end

    test "does not include substring", %{actual: a_string} do
      expect a_string, to_not: include("Clo")
    end

    test "starts with substring", %{actual: a_string} do
      expect a_string, to: start_with("Hello")
    end

    test "does not start with substring", %{actual: a_string} do
      expect a_string, to_not: start_with("Goodbye")
    end

    test "ends with substring", %{actual: a_string} do
      expect a_string, to: end_with("Elixir")
    end

    test "does not end with substring", %{actual: a_string} do
      expect a_string, to_not: end_with("Clojure")
    end

    test "matches a regex", %{actual: a_string} do
      expect a_string, to: match(~r/ello/)
    end

    test "does not match a regex", %{actual: a_string} do
      expect a_string, to_not: match(~r/Bye/)
    end

    test "can be written withouth spliting infinitives", %{actual: a_string} do
      expect a_string, not_to: eq("Hello Clojure")
    end
  end

  describe "a string failed assertions" do
    setup do
      %{actual: "Hello Elixir"}
    end

    test "is equal to another", %{actual: a_string} do
      expect_assertion_to_fail fn() -> expect  a_string, to: eq("Bye Elixir") end
    end

    test "is not equal to another", %{actual: a_string} do
      expect_assertion_to_fail fn() -> expect  a_string, to_not: eq("Hello Elixir") end
    end

    test "have items", %{actual: a_string} do
      expect_assertion_to_fail fn() -> expect  a_string, to: have_items(10) end
    end

    test "is not empty" do
      expect_assertion_to_fail fn() -> expect  "", to_not: be_empty() end
    end

    test "includes substring", %{actual: a_string} do
      expect_assertion_to_fail fn() -> expect  a_string, to: include("Cloj") end
    end

    test "does not include substring", %{actual: a_string} do
      expect_assertion_to_fail fn() -> expect  a_string, to_not: include("Elix") end
    end

    test "starts with substring", %{actual: a_string} do
      expect_assertion_to_fail fn() -> expect  a_string, to: start_with("Bye") end
    end

    test "does not start with substring", %{actual: a_string} do
      expect_assertion_to_fail fn() -> expect  a_string, to_not: start_with("Hello") end
    end

    test "ends with substring", %{actual: a_string} do
      expect_assertion_to_fail fn() -> expect  a_string, to: end_with("Clojure") end
    end

    test "does not end with substring", %{actual: a_string} do
      expect_assertion_to_fail fn() -> expect  a_string, to_not: end_with("Elixir") end
    end

    test "matches a regex", %{actual: a_string} do
      expect_assertion_to_fail fn() -> expect  a_string, to: match(~r/bye/) end
    end

    test "does not match a regex", %{actual: a_string} do
      expect_assertion_to_fail fn() -> expect  a_string, to_not: match(~r/ello/) end
    end
  end
end
