defmodule Howmanycanplay.PlatformsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Howmanycanplay.Platforms` context.
  """

  @doc """
  Generate a platform.
  """
  def platform_fixture(attrs \\ %{}) do
    {:ok, platform} =
      attrs
      |> Enum.into(%{
        abbreviation: "some abbreviation",
        alternative_name: "some alternative_name",
        api_id: 42,
        name: "some name",
        slug: "some slug"
      })
      |> Howmanycanplay.Platforms.create_platform()

    platform
  end
end
