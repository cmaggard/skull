defmodule Skull.Game.Query do
  alias Skull.Game

  def player_count(game) do
    map_size(game.players)
  end
end
