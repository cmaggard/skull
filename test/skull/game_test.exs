defmodule Skull.GameTest do
  use ExUnit.Case

  alias Skull.Game
  alias Skull.Game.Query

  describe "new_game/0" do
    test "builds a new game" do
      assert is_map(Game.new_game())
    end
  end

  describe "add_player/2" do
    test "it adds a player to the game" do
      {:ok, game} =
        Game.new_game()
        |> add_player()

      assert Query.player_count(game) == 1
    end

    test "adding another player when there are six players fails" do
      game = Game.new_game()

      game =
        Enum.reduce(1..6, game, fn player, acc ->
          {:ok, game} = add_player(acc, name: "Player " <> Integer.to_string(player))
          game
        end)

      {result, _game} = add_player(game)
      assert result == {:error, :player_count_exceeded}
    end
  end

  describe "remove_player/2" do
    test "it removes a player from the game" do
      id = Skull.Helper.generate_id()

      {:ok, game} =
        Game.new_game()
        |> add_player(id: id)

      {:ok, game} = Game.remove_player(game, id)
      assert Query.player_count(game) == 0
    end
  end

  defp add_player(game, args \\ []) do
    name = Keyword.get(args, :name, "Cody")
    pid = Keyword.get(args, :pid, self())
    id = Keyword.get(args, :id, Skull.Helper.generate_id())
    Game.add_player(game, name: name, pid: pid, id: id)
  end
end
