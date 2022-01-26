defmodule Howmanycanplay.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias Howmanycanplay.Games.Game

  schema "games" do
    field :name, :string
    field :summary, :string
    field :api_id, :integer
    many_to_many :genres, Howmanycanplay.Genres.Genre, join_through: "games_genres"

    timestamps()
  end

  @required ~w[name summary]a

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :summary, :api_id])
    |> validate_required(@required)
    |> unique_constraint(:api_id, name: :games_api_id_uniq_idx)
  end

  def assoc_genres(changeset, %{genres: []}) do
    changeset
  end

  def assoc_genres(changeset, %{genres: genres}) do
    changeset
    |> put_assoc(:genres, genres)
  end

  def api_game_changeset(game, api_game) do
    game
    |> changeset(api_game)
    |> assoc_genres(api_game)
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
