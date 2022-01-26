defmodule Howmanycanplay.Platforms do
  @moduledoc """
  The Platforms context.
  """

  import Ecto.Query, warn: false
  alias Howmanycanplay.Repo

  alias Howmanycanplay.Platforms.Platform

  @doc """
  Returns the list of platforms.

  ## Examples

      iex> list_platforms()
      [%Platform{}, ...]

  """
  def list_platforms do
    Repo.all(Platform)
  end

  @doc """
  Gets a single platform.

  Raises `Ecto.NoResultsError` if the Platform does not exist.

  ## Examples

      iex> get_platform!(123)
      %Platform{}

      iex> get_platform!(456)
      ** (Ecto.NoResultsError)

  """
  def get_platform!(id), do: Repo.get!(Platform, id)

  @doc """
  Creates a platform.

  ## Examples

      iex> create_platform(%{field: value})
      {:ok, %Platform{}}

      iex> create_platform(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_platform(attrs \\ %{}) do
    %Platform{}
    |> Platform.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a platform.

  ## Examples

      iex> update_platform(platform, %{field: new_value})
      {:ok, %Platform{}}

      iex> update_platform(platform, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_platform(%Platform{} = platform, attrs) do
    platform
    |> Platform.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a platform.

  ## Examples

      iex> delete_platform(platform)
      {:ok, %Platform{}}

      iex> delete_platform(platform)
      {:error, %Ecto.Changeset{}}

  """
  def delete_platform(%Platform{} = platform) do
    Repo.delete(platform)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking platform changes.

  ## Examples

      iex> change_platform(platform)
      %Ecto.Changeset{data: %Platform{}}

  """
  def change_platform(%Platform{} = platform, attrs \\ %{}) do
    Platform.changeset(platform, attrs)
  end
end
