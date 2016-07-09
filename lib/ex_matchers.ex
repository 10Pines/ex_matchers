defmodule ExMatchers do
  defmacro __using__(_opts) do
    quote do
      import ExMatchers.Expect
      import ExMatchers.Size
      import ExMatchers.Include
      import ExMatchers.Equal
      import ExMatchers.StartWith
      import ExMatchers.EndWith
      import ExMatchers.LessThan
      import ExMatchers.LessOrEqualThan
      import ExMatchers.GreaterThan
      import ExMatchers.GreaterOrEqualThan
      import ExMatchers.Match
      import ExMatchers.RaiseError
      import ExMatchers.Custom
    end
  end
end
