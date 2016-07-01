defmodule ExMatchers.Base do
  @moduledoc false

  def run_matcher(matcher, expected) do
    fn(actual, assertion) ->
      case assertion do
        :assert -> matcher.to_match(actual, expected)
        :refute -> matcher.to_not_match(actual, expected)
      end
    end
  end

end