defmodule ParallelDotsTest do
  use ExUnit.Case
  require Logger
  doctest ParallelDots

  test "intent analysis" do
    case ParallelDots.text_analysis("what do you want from me", "intent") do
      {:ok, response} ->
        assert response["code"] == 200

      {:error, reason} ->
        assert false
    end
  end
end
