defmodule Breakdown.Game.Turn do
  def new do
    []
  end

  def add_letter(guess, letter) do
    case length(guess) do
      5 -> guess
      _ -> [letter | guess]
    end
  end

  def remove_letter([]) do
    []
  end

  def remove_letter([_head | tail]) do
    tail
  end

  def to_guess(guess), do: Enum.reverse(guess) |> to_string
  # def to_guess(guess) do
  #   case length(guess) do
  #     5 -> {:ok, Enum.reverse(guess) |> to_string}
  #     _ -> {:error, "Invalid length"}
  #   end
  # end
end
