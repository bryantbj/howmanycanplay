defmodule Howmanycanplay.PlatformsTest do
  use Howmanycanplay.DataCase

  alias Howmanycanplay.Platforms

  describe "platforms" do
    alias Howmanycanplay.Platforms.Platform

    import Howmanycanplay.PlatformsFixtures

    @invalid_attrs %{abbreviation: nil, alternative_name: nil, api_id: nil, name: nil, slug: nil}

    test "list_platforms/0 returns all platforms" do
      platform = platform_fixture()
      assert Platforms.list_platforms() == [platform]
    end

    test "get_platform!/1 returns the platform with given id" do
      platform = platform_fixture()
      assert Platforms.get_platform!(platform.id) == platform
    end

    test "create_platform/1 with valid data creates a platform" do
      valid_attrs = %{abbreviation: "some abbreviation", alternative_name: "some alternative_name", api_id: 42, name: "some name", slug: "some slug"}

      assert {:ok, %Platform{} = platform} = Platforms.create_platform(valid_attrs)
      assert platform.abbreviation == "some abbreviation"
      assert platform.alternative_name == "some alternative_name"
      assert platform.api_id == 42
      assert platform.name == "some name"
      assert platform.slug == "some slug"
    end

    test "create_platform/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Platforms.create_platform(@invalid_attrs)
    end

    test "update_platform/2 with valid data updates the platform" do
      platform = platform_fixture()
      update_attrs = %{abbreviation: "some updated abbreviation", alternative_name: "some updated alternative_name", api_id: 43, name: "some updated name", slug: "some updated slug"}

      assert {:ok, %Platform{} = platform} = Platforms.update_platform(platform, update_attrs)
      assert platform.abbreviation == "some updated abbreviation"
      assert platform.alternative_name == "some updated alternative_name"
      assert platform.api_id == 43
      assert platform.name == "some updated name"
      assert platform.slug == "some updated slug"
    end

    test "update_platform/2 with invalid data returns error changeset" do
      platform = platform_fixture()
      assert {:error, %Ecto.Changeset{}} = Platforms.update_platform(platform, @invalid_attrs)
      assert platform == Platforms.get_platform!(platform.id)
    end

    test "delete_platform/1 deletes the platform" do
      platform = platform_fixture()
      assert {:ok, %Platform{}} = Platforms.delete_platform(platform)
      assert_raise Ecto.NoResultsError, fn -> Platforms.get_platform!(platform.id) end
    end

    test "change_platform/1 returns a platform changeset" do
      platform = platform_fixture()
      assert %Ecto.Changeset{} = Platforms.change_platform(platform)
    end
  end
end
