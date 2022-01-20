defmodule Howmanycanplay.GenresFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Howmanycanplay.Genres` context.
  """

  @doc """
  Generate a genre.
  """
  def genre_fixture(attrs \\ %{}) do
    {:ok, genre} =
      attrs
      |> Enum.into(%{
        api_id: 42,
        name: "some name"
      })
      |> Howmanycanplay.Genres.create_genre()

    genre
  end
end
