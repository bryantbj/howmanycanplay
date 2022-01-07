defmodule Howmanycanplay.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias Howmanycanplay.Games.Game

  schema "games" do
    field :name, :string
    field :summary, :string

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :summary])
    |> validate_required([:name, :summary])
  end

  def new_from_api(data) when is_map(data) do
    %Game{}
    |> Map.put(:name, data.name)
    |> Map.put(:summary, data.summary)
    |> Map.put(:game_modes, Enum.map(data.game_modes, & &1.name))
    |> Map.put(:genres, Enum.map(data.genres, & &1.name))
    |> Map.put(:platforms, Enum.map(data.platforms, &Map.take(&1, ~w[name abbreviation]a)))
    |> Map.put(
      :multiplayer_modes,
      Enum.map(data.multiplayer_modes, fn mode ->
        case mode do
          %{:platform => platform} ->
            Enum.find(data.platforms, &(&1.id == platform))
            |> Map.take(~w[name abbreviation]a)
            |> then(fn data -> Map.put(mode, :platform, data) end)

          mode ->
            mode
        end
      end)
    )
  end
end
