defmodule Skull.Game do
  alias Skull.Game.Query

  def new_game do
    %{
      players: %{}
    }
  end

  def add_player(game, _args = [name: name, pid: pid, ref: ref]) do
    cond do
      Query.player_count(game) == 6 ->
        {{:error, :player_count_exceeded}, game}

      true ->
        game = put_in(game, [:players, ref], %{pid: pid, name: name})
        {:ok, game}
    end
  end

  def remove_player(game, ref) do
    {_player, game} = pop_in(game, [:players, ref])
    {:ok, game}
  end

  end
end
