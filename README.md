# ExMatchers

Matchers that provide syntactic sugar around ExUnit assertions. The goal of this library is to help writing readable tests and to facilitate the process of writing reusable domain specific custom matchers.

## Built in matchers

Full list of matchers is [here](https://github.com/10Pines/ex_matchers/wiki)

Example:
```elixir
defmodule MyTest do
  use ExUnit.Case, async: true
  use ExMatchers

  test "returns an empty result" do
    result = []

    expect result, to: be_empty()
  end

  test "returns a non-empty result" do
    result = [1, 2, 3]

    expect result, to_not: be_empty()
  end

  test "returns a map with the meaning of life" do
    result = calculate_meaning_of_life()

    expect result, to:   include(:meaning_of_life),
                   with: 42
  end
end

```

## Custom matchers

You can define your own matchers using the `defmatcher` macro.

Example:

```elixir
defmodule MyMatchers do
  import ExUnit.Assertions
  import ExMatchers.Custom

  defmodule Pizza do
    defstruct cheeses: [], toppings: [], vegetarian: false, price: 0.0
  end

  defmodule PizzaIsVegetarian do
    def to_match(pizza) do
      assert pizza.vegetarian
    end
    def to_not_match(pizza) do
      refute pizza.vegetarian
    end
  end
  defmatcher be_veggie, matcher: PizzaIsVegetarian
end

defmodule MyTest do
  use ExUnit.Case, async: true
  use ExMatchers
  import MyMatchers

  test "is veggie" do
    a_pizza = %Pizza{cheeses: [:mozzarella], toppings: [:tomato, :basil], vegetarian: true, price: 14.25}

    expect a_pizza, to: be_veggie()
  end

  test "is not veggie" do
    a_pizza = %Pizza{cheeses: [:mozzarella], toppings: [:tomato, :salami], vegetarian: false, price: 15.12}

    expect a_pizza, to_not: be_veggie()
  end
end
```

By adding to the matcher definition a `{with: something}`, then you can pass any other arbitrary `{key: value}` to the expect function and it will be passed to the matcher in the last argument.

Example:
```elixir
defmodule PizzaHasPrice do
  def to_match(pizza, price, delta) do
    assert_in_delta pizza.price, price, delta
  end
  def to_not_match(pizza, price, delta) do
    refute_in_delta pizza.price, price, delta
  end
end
defmatcher has_price(price), with: delta, matcher: PizzaHasPrice

defmodule MyTest do
  use ExUnit.Case, async: true
  use ExMatchers
  import MyMatchers

  setup do
    %{actual: %Pizza{cheeses: [:mozzarella], toppings: [:tomato, :basil], vegetarian: true, price: 14.25}}
  end

  test "is priced", %{actual: a_pizza} do
    expect a_pizza, to:     has_price(14.2),
                    within: 0.10
  end
end
```

## Future work

* New library for Ecto and Phoenix matchers

## Installation

Add `ex_matchers` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ex_matchers, "~> 0.1.5", only: :test}]
end
```
