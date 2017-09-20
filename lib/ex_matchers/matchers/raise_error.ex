defmodule ExMatchers.RaiseError do
  @moduledoc false

  import ExUnit.Assertions
  import ExMatchers.Custom

  defmodule RaiseErrorMatcher do
    
    def to_match(function, error) do
      assert_raise error, function
    end

    def to_match(function, error, message) do
      assert_raise error, message, function
    end

    def to_not_match(function, error) do
      flunk "Matcher does not support to not match an error not being raised on #{function} with #{error}"
    end

    def to_not_match(function, error, message) do
      flunk "Matcher does not support to not match an error not being raised on #{function} with #{error} and #{message}"
    end
  end

  defmatcher raise_error(error), with: message, matcher: RaiseErrorMatcher
end
