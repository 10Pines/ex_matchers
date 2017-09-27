defmodule ExMatchers.Expect do
  @moduledoc false

  def expect(value, to: matcher) do
    matcher.(value, :assert)
  end

  def expect(value, to_not: matcher) do
     matcher.(value, :refute)
  end

  def expect(value, not_to: matcher) do
     expect(value, to_not: matcher)
  end

  def expect(actual_value, options) do
    matcher = options[:to] || options[:to_not]
    action = if Keyword.has_key?(options, :to), do: :assert, else: :refute
    extra_arguments = options |> Keyword.drop([:to, :to_not, :not_to]) |> Keyword.values |> List.first
    matcher.(actual_value, {action, extra_arguments})
  end

end
