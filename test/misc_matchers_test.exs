defmodule StringMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers
  import AssertHelpers

  describe "a matcher" do
    setup do
      %{actual: "Hello Elixir"}
    end

    test "can be written withouth spliting infinitives", %{actual: a_string} do
      expect a_string, not_to: eq("Hello Clojure")
    end
  end
end
