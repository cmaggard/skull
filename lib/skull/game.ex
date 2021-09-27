defmodule Skull.Game do
  alias Skull.Game.Query

  def new_game do
    %{
      players: %{}
    }
  end

  def add_player(game, _args = [name: name, pid: pid, id: id]) do
    cond do
      Query.player_count(game) == 6 ->
        {{:error, :player_count_exceeded}, game}

      true ->
        game = put_in(game, [:players, id], %{pid: pid, name: name})
        {:ok, game}
    end
  end

  def remove_player(game, id) do
    {_player, game} = pop_in(game, [:players, id])
    {:ok, game}
  end
end
