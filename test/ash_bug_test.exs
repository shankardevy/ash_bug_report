defmodule AshBugTest do
  use ExUnit.Case
  doctest AshBug

  test "greets the world" do
    assert AshBug.hello() == :world
  end
end
