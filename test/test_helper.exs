ExUnit.start()

defmodule AssertHelpers do
  use ExMatchers

  def expect_assertion_to_fail(assert_function) do
    expect assert_function, to: raise_error(ExUnit.AssertionError)
  end
end
