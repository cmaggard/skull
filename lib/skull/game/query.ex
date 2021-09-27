defmodule Skull.Game.Query do
  alias Skull.Game

  def player_count(game) do
    map_size(game.players)
  end

  def get_player_ids(game) do
    Map.keys(game.players)
  end

  def get_player_state(game, player_id) do
    game.player_states[player_id]
  end
end
