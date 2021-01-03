alias Howmanycanplay.Repo
alias Howmanycanplay.Games.{Game, ModeType, Mode, Platform}
# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Howmanycanplay.Repo.insert!(%Howmanycanplay.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Seed the available platforms
["Windows", "Stadia", "Xbox One", "PS4", "PS5", "Nintendo Switch"]
|> Enum.map(&Repo.insert!(%Platform{name: &1}))

[_, online_coop, pvp, pvpve | _other_modes] =
  ["local co-op", "online co-op", "pvp", "pvpve", "local", "online", "multiplayer"]
  |> Enum.map(fn name -> Repo.insert!(%ModeType{name: name}) end)

# Seed some games
[destiny | _other_games] =
  ["Destiny 2", "Overwatch", "A Way Out"]
  |> Enum.map(fn name -> Repo.insert!(%Game{name: name}) end)

# Add a mode to destiny
Repo.insert!(%Mode{
  game_id: destiny.id,
  mode_type_id: online_coop.id,
  name: "Standard Fireteam",
  description: "Standard mode for campaign and most activities",
  player_max_num: 3
})

Repo.insert!(%Mode{
  game_id: destiny.id,
  mode_type_id: online_coop.id,
  name: "Dungeon",
  description: "Raid-like instances for standard fireteams",
  player_min_num: 3,
  player_max_num: 3
})

Repo.insert!(%Mode{
  game_id: destiny.id,
  mode_type_id: online_coop.id,
  name: "Raid",
  player_min_num: 6,
  player_max_num: 6
})

Repo.insert!(%Mode{
  game_id: destiny.id,
  mode_type_id: pvp.id,
  name: "Crucible",
  player_min_num: 1,
  player_max_num: 4
})

Repo.insert!(%Mode{
  game_id: destiny.id,
  mode_type_id: pvpve.id,
  name: "Gambit",
  description:
    "Teams compete by depositing motes dropped by defeated enemies and fighting a boss once enough motes are deposited",
  player_min_num: 1,
  player_max_num: 4
})
