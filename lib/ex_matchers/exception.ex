defmodule ExMatchers.Exception do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom

  defmodule ErrorMatcher do
    def to_match(function, error) do
      assert_raise error, function
    end
    def to_match(function, error, message) do
      assert_raise error, message, function
    end
  end

  defmatcher raise_error(error), with: ErrorMatcher
end