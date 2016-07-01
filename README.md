# ExMatchers

Matchers that provide syntactic sugar around ExUnit assertions.

## Example

Full list of matchers is [here](https://github.com/10Pines/ex_matchers/wiki)

```elixir
defmodule MyTest do
  use ExUnit.Case, async: true
  use ExMatchers

  test "returns an empty result" do
    result = # do something

    expect result, to: be_empty
  end

  test "returns a non-empty result" do
    result = # do something

    expect result, to_not: be_empty
  end

  test "returns a map with the meaning of life" do
    result = # calculate meaning of life

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

  defmodule Reminder do
    defstruct title: "", due_date: nil, archived: false
  end

  defmodule ReminderIsArchived do
    def to_match(reminder) do
      assert reminder.archived
    end
    def to_not_match(reminder) do
      refute reminder.archived
    end
  end
  defmatcher be_archived, with: ReminderIsArchived
end

defmodule MyTest do
  use ExUnit.Case, async: true
  use ExMatchers
  import MyMatchers

  test "is archived" do
    a_reminder = %Reminder{archived: true}
    expect a_reminder, to: be_archived
  end

  test "is not archived" do
    a_reminder = %Reminder{archived: false}
    expect a_reminder, to_not: be_archived
  end
end
```

You can pass any other arbitrary key to the expect function and it will be passed to the matcher in the last argument.

Example:
```elixir
  defmodule ReminderIsExpired do
    def to_match(reminder) do
      assert reminder.due_date > DateTime.utc_now
    end
    def to_match(reminder, due_date) do
      assert reminder.due_date > due_date
    end
  end
  defmatcher be_expired, with: ReminderIsExpired
end

defmodule MyTest do
  use ExUnit.Case, async: true
  use ExMatchers
  import MyMatchers

  test "is expired" do
    a_reminder = %Reminder{due_date: DateTime.utc_now}
    expect a_reminder, to: be_expired
  end

  test "is not archived" do
    a_reminder = %Reminder{due_date: DateTime.utc_now}
    expect a_reminder, to: be_expired,
                       on: DateTime.utc_now
  end
end
```

## Installation

Add `ex_matchers` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ex_matchers, "~> 0.1.0", only: :test}]
    end
    ```
