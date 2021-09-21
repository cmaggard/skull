defmodule Skull.Game do
  defstruct players: []

  def new_game do
    %__MODULE__{}
  end

  def add_player(game, name: name, pid: pid, ref: ref) do
    cond do
      player_count(game) == 6 ->
        {{:error, :player_count_exceeded}, game}

      true ->
        game = %{game | players: [{ref, pid, name} | game.players]}
        {:ok, game}
    end
  end

  def remove_player(game, ref) do
    new_players = Enum.reject(game.players, fn {p_ref, _pid, _name} -> ref == p_ref end)
    {:ok, %{game | players: new_players}}
  end

  def player_count(game) do
    length(game.players)
  end
end
