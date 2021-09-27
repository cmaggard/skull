defmodule Skull.Game do
  alias Skull.Game.Query
  alias Skull.PlayerState

  def new_game do
    %{
      players: %{},
      player_order: [],
      current_player: nil
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

  def build_player_states(game) do
    player_state =
      Map.keys(game.players)
      |> Enum.reduce(%{}, fn player, acc ->
        Map.put(acc, player, PlayerState.build_state())
      end)

    {:ok, Map.put(game, :player_state, player_state)}
  end

  def randomize_player_order(game) do
    players = Map.keys(game.players)
    randomized = Enum.shuffle(players)
    game = %{game | player_order: randomized, current_player: Enum.at(randomized, 0)}
    {:ok, game}
  end
end
