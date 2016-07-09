defmodule StringMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers

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
      expect a_string, to_not: be_empty
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
  end
end
