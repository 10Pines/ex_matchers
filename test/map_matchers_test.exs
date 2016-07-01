defmodule MapMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers

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
      expect a_map, to_not: be_empty
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
end
