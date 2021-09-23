defmodule Skull.PlayerState do
  def build_state do
    %{
      normal: 3,
      skulls: 1,
      played_cards: [],
      bid_state: nil
    }
  end

  def play_card(state, card) when card in [:skull, :normal] do
    if can_play?(state, card) do
      {:ok, %{state | played_cards: [card | state.played_cards]}}
    else
      {{:error, :unplayable}, state}
    end
  end

  def can_play?(state, :normal) do
    state.normal > num_played_cards_of_type(state, :normal)
  end

  def can_play?(state, :skull) do
    state.skulls > num_played_cards_of_type(state, :skull)
  end

  defp num_played_cards_of_type(state, type) do
    state.played_cards
    |> Enum.filter(&(&1 == type))
    |> length()
  end
end
