defmodule Howmanycanplay.ApiGame do
  @derive Jason.Encoder
  defstruct [
    :id,
    :name,
    :summary,
    :api_id,
    :follows,
    :cover_url,
    :thumb_url,
    :year_released,
    game_modes: [],
    genres: [],
    multiplayer_modes: [],
    platforms: []
  ]

  def new(map) when is_map(map) do
    %__MODULE__{}
    |> Map.put(:id, map[:id])
    |> Map.put(:api_id, map[:id])
    |> Map.put(:name, map[:name])
    |> Map.put(:summary, map[:summary])
    |> Map.put(:follows, map[:follows])
    |> Map.put(:game_modes, Enum.map(map[:game_modes] || [], & &1[:name]))
    |> Map.put(:genres, Enum.map(map[:genres] || [], & &1[:name]))
    |> put_cover_url(map)
    |> put_dates(map)
    |> put_platforms(map)
    |> put_multiplayer_modes(map)
  end

  def merge_multiplayer_modes(modes) do
    modes
    |> Enum.map(fn mode ->
      Map.take(
        mode,
        ~w[campaigncoop dropin lancoop offlinecoop onlinecoop onlinecoopmax onlinemax splitscreen]a
      )
    end)
    |> Enum.all?(& &1)
    |> if do
      [hd(modes)]
    else
      modes
    end
  end

  def put_platforms(destination, %{:platforms => platforms}) do
    platforms
    |> Enum.map(&Map.take(&1, ~w[name abbreviation]a))
    |> then(&Map.put(destination, :platforms, &1))
  end

  def put_platforms(destination, _), do: destination

  def put_multiplayer_modes(destination, %{:multiplayer_modes => modes} = source) do
    modes =
      modes
      |> Enum.map(fn mode ->
        case mode do
          %{:platform => platform} ->
            Enum.find(source[:platforms] || [], &(&1[:id] == platform))
            |> Map.take(~w[name abbreviation]a)
            |> then(&Map.put(mode, :platform, &1))

          mode ->
            mode
        end
      end)

    onlinecoopmax = Enum.max_by(modes, & &1[:onlinecoopmax])[:onlinecoopmax]

    destination
    |> Map.put(:multiplayer_modes, modes)
    |> Map.put(:onlinecoopmax, onlinecoopmax || -1)
  end

  def put_multiplayer_modes(destination, _) do
    destination
    |> Map.put(:multiplayer_modes, [])
    |> Map.put(:onlinecoopmax, -1)
  end

  def put_dates(destination, %{:release_dates => dates}) do
    dates =
      dates
      |> Enum.filter(& &1[:date])
      |> Enum.map(&DateTime.from_unix!(&1[:date]))
      |> Enum.map(&%{date: "#{&1.year}-#{&1.month}-#{&1.day}", year: &1.year})

    year_released = (Enum.any?(dates) and Enum.min_by(dates, & &1[:year])[:year]) || nil

    destination
    |> Map.put(:release_dates, dates)
    |> Map.put(:year_released, year_released)
  end

  def put_dates(destination, _) do
    destination
    |> Map.put(:release_dates, [])
    |> Map.put(:year_released, nil)
  end

  def put_cover_url(destination, %{cover: %{url: url}}) do
    thumb = String.replace(url, "thumb", "cover_big")
    cover = String.replace(url, "thumb", "cover_big_2x")

    destination
    |> Map.put(:thumb_url, thumb)
    |> Map.put(:cover_url, cover)
  end

  def put_cover_url(destination, _) do
    destination
    |> Map.put(:cover_url, nil)
  end
end
