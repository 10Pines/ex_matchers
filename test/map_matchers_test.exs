defmodule MapMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers
  import AssertHelpers

  describe "a map" do
    setup do
      %{actual: %{a: 1, b: %{c: 2}}}
    end

    test "is equal to another", %{actual: a_map} do
      expect a_map, to: eq(%{a: 1, b: %{c: 2}})
    end

    test "is not equal to another", %{actual: a_map} do
      expect a_map, to_not: eq(%{a: 1, b: 2})
    end

    test "have items", %{actual: a_map} do
      expect a_map, to: have_items(2)
    end

    test "is not empty", %{actual: a_map} do
      expect a_map, to_not: be_empty()
    end

    test "includes key", %{actual: a_map} do
      expect a_map, to: include(:a)
    end

    test "includes key with value", %{actual: a_map} do
      expect a_map, to:   include(:a),
                    with: 1
    end

    test "includes nested keys with value", %{actual: a_map} do
      expect a_map, to:   include([:b, :c]),
                    with: 2
    end

    test "does not include key", %{actual: a_map} do
      expect a_map, to_not: include(:d)
    end

    test "does not include key with value", %{actual: a_map} do
      expect a_map, to_not: include(:a),
                    with:   2
    end

    test "does not include nested keys with value", %{actual: a_map} do
      expect a_map, to_not: include([:b, :c]),
                    with:   1
    end
  end

  describe "a map failed assertions" do
    setup do
      %{actual: %{a: 1, b: %{c: 2}}}
    end

    test "is equal to another", %{actual: a_map} do
      expect_assertion_to_fail fn() -> expect a_map, to: eq(%{b: %{c: 2}}) end
    end

    test "is not equal to another", %{actual: a_map} do
      expect_assertion_to_fail fn() -> expect a_map, to_not: eq(a_map) end
    end

    test "have items", %{actual: a_map} do
      expect_assertion_to_fail fn() -> expect a_map, to: have_items(1) end
    end

    test "is not empty" do
      expect_assertion_to_fail fn() -> expect %{}, to_not: be_empty() end
    end

    test "includes key", %{actual: a_map} do
      expect_assertion_to_fail fn() -> expect a_map, to: include(:d) end
    end

    test "includes key with value", %{actual: a_map} do
      expect_assertion_to_fail fn() ->
        expect a_map, to:   include(:a),
                      with: 2
      end
    end

    test "includes nested keys with value", %{actual: a_map} do
      expect_assertion_to_fail fn() ->
        expect a_map, to:   include([:b, :c]),
                      with: 3
      end
    end

    test "does not include key", %{actual: a_map} do
      expect_assertion_to_fail fn() -> expect a_map, to_not: include(:a) end
    end

    test "does not include key with value", %{actual: a_map} do
      expect_assertion_to_fail fn() ->
        expect a_map, to_not: include(:a),
                      with:   1
      end
    end

    test "does not include nested keys with value", %{actual: a_map} do
      expect_assertion_to_fail fn() ->
        expect a_map, to_not: include([:b, :c]),
                    with:   2
      end
    end
  end
end
