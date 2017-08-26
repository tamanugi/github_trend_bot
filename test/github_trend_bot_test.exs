defmodule GithubTrendBotTest do
  use ExUnit.Case
  doctest GithubTrendBot

  test "greets the world" do
    assert GithubTrendBot.hello() == :world
  end
end
