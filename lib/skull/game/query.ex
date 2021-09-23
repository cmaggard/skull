defmodule Skull.Game.Query do
  alias Skull.Game

  def player_count(game) do
    length(game.players)
  end
end
