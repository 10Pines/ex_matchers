defmodule ExMatchers do
  defmacro __using__(_opts) do
    quote do
      import ExMatchers.Expect
      import ExMatchers.Size
      import ExMatchers.Include
      import ExMatchers.Equals
      import ExMatchers.StartsWith
      import ExMatchers.EndsWith
      import ExMatchers.LessThan
      import ExMatchers.LessOrEqualThan
      import ExMatchers.GreaterThan
      import ExMatchers.GreaterOrEqualThan
      import ExMatchers.Exception
      import ExMatchers.Custom
    end
  end
end
