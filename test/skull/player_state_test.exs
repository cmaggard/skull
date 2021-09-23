defmodule Skull.PlayerStateTest do
  use ExUnit.Case

  alias Skull.PlayerState

  describe "build_state/0" do
    setup :build_player_state

    test "it creates a new player state", context do
      assert is_map(context[:player_state])
    end

    test "it adds one skull card", context do
      assert context[:player_state].skulls == 1
    end

    test "it adds three normal card", context do
      assert context[:player_state].normal == 3
    end

    test "it shows no cards as played", context do
      assert context[:player_state].played_cards == []
    end

    test "it has an empty bid state", context do
      assert context[:player_state].bid_state == nil
    end
  end

  describe "play_card/2" do
    setup :build_player_state

    test "plays a normal card", context do
      {:ok, state} = PlayerState.play_card(context[:player_state], :normal)
      assert state.played_cards == [:normal]
    end

    test "when all normal cards are played, return an error when playing a normal card",
         context do
      state = context[:player_state]

      state = play_cards(state, :normal, state.normal)

      {result, _state} = PlayerState.play_card(state, :normal)
      assert {:error, :unplayable} == result
    end

    test "plays a skull", context do
      {:ok, state} = PlayerState.play_card(context[:player_state], :skull)
      assert state.played_cards == [:skull]
    end

    test "when all skull cards are played, return an error when playing a skull", context do
      state = context[:player_state]

      state = play_cards(state, :skull, state.skulls)

      {result, _state} = PlayerState.play_card(state, :skull)
      assert {:error, :unplayable} == result
    end
  end

  defp build_player_state(_context) do
    [player_state: PlayerState.build_state()]
  end

  defp play_cards(state, card, count) do
    Enum.reduce(1..count, state, fn _i, acc ->
      {:ok, s} = PlayerState.play_card(acc, card)
      s
    end)
  end
end
