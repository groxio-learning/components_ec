defmodule Breakdown.Game do
  alias Breakdown.Game.Core
  alias Breakdown.Words

  def new() do
    Words.random()
    |> Core.new()
  end

  @doc """
  TODO: Validation will go here!
  """
  def guess(game, guess) do
    Core.guess(game, guess)
  end

  def render(game) do
    Core.show(game)
  end

  def validate_guess(guess) do
    if Words.member?(guess) do
      {:ok, guess}
    else
      {:error, "Guess must be in dictionary"}
    end
  end
end
