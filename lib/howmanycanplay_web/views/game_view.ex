defmodule HowmanycanplayWeb.GameView do
  use HowmanycanplayWeb, :view
  alias Howmanycanplay.Games

  def results_json(results) do
    results
    |> Enum.map(&result_json/1)
  end

  def result_json(result) do
    %{
      id: result.id,
      name: result.name,
      modes:
        Enum.reduce(result.modes, [], fn %{
                                           name: name,
                                           description: desc,
                                           player_min_num: min,
                                           player_max_num: max,
                                           mode_type: type
                                         },
                                         acc ->
          [%{name: name, description: desc, min: min, max: max, mode_type: type.name} | acc]
        end)
    }
  end

  def min_max_players_text(%{min_max_players: minmax = %{min: _min, max: _max}}) do
    min_max_players_text(minmax)
  end

  def min_max_players_text(game = %Games.Game{}) do
    minmax = %{min: _min, max: _max} = Games.min_max_players(game)

    min_max_players_text(minmax)
  end

  def min_max_players_text(%{min: min, max: max}) do
    cond do
      min && max ->
        "#{min} - #{max}"

      min == nil && max == nil ->
        ""

      min == max ->
        "#{min}"

      true ->
        ""
    end
  end

  def min_max(%{min_max_players: minmax = %{min: _min, max: max}}) do
    %{show?: (max && true) || false, text: min_max_players_text(minmax)}
  end
end
