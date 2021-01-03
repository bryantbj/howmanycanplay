defmodule HowmanycanplayWeb.GameView do
  use HowmanycanplayWeb, :view

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
end
