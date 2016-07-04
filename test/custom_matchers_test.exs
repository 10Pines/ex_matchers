defmodule CustomMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers

  defmodule Pizza do
    defstruct cheeses: [], toppings: [], vegetarian: false, price: 0.0
  end

  describe "a custom matcher without arguments" do
    defmodule PizzaIsVegetarian do
      def to_match(pizza) do
        assert pizza.vegetarian
      end
      def to_not_match(pizza) do
        refute pizza.vegetarian
      end
    end
    defmatcher be_veggie, with: PizzaIsVegetarian

    test "is veggie" do
      a_pizza = %Pizza{cheeses: [:mozzarella], toppings: [:tomato, :basil], vegetarian: true, price: 14.25}
      expect a_pizza, to: be_veggie
    end

    test "is not veggie" do
      a_pizza = %Pizza{cheeses: [:mozzarella], toppings: [:tomato, :salami], vegetarian: false, price: 15.12}
      expect a_pizza, to_not: be_veggie
    end
  end

  describe "a custom matcher with argument" do
    defmodule PizzaIncludeTopping do
      def to_match(pizza, topping) do
        assert topping in pizza.toppings
      end
      def to_not_match(pizza, topping) do
        refute topping in pizza.toppings
      end
    end

    defmatcher include_topping(topping), with: PizzaIncludeTopping

    setup do
      %{actual: %Pizza{cheeses: [:mozzarella], toppings: [:tomato, :salami], vegetarian: false, price: 15.12}}
    end

    test "includes topping", %{actual: a_pizza} do
      expect a_pizza, to: include_topping(:salami)
    end

    test "do not include topping", %{actual: a_pizza} do
      expect a_pizza, to_not: include_topping(:brocoli)
    end
  end

  describe "a custom matcher with arguments and delta" do
    defmodule PizzaHasPrice do
      def to_match(pizza, price, delta) do
        assert_in_delta pizza.price, price, delta
      end
      def to_not_match(pizza, price, delta) do
        refute_in_delta pizza.price, price, delta
      end
    end
    defmatcher has_price(price), with: PizzaHasPrice

    setup do
      %{actual: %Pizza{cheeses: [:mozzarella], toppings: [:tomato, :basil], vegetarian: true, price: 14.25}}
    end

    test "is priced", %{actual: a_pizza} do
      expect a_pizza, to:     has_price(14.2),
                      within: 0.10
    end
    test "is not priced", %{actual: a_pizza} do
      expect a_pizza, to_not: has_price(14.2),
                      within: 0.01
    end
  end
end
