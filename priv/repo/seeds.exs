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
alias Howmanycanplay.{Repo, Genres.Genre, Platforms.Platform, Games.Game}
now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

# >> Genres
#
# These are all the genres in the IGDB database.
# Rather than dynamically inserting them when
# users visit a game listing, they've been
# pulled for seeding instead.
[
  %{api_id: 4, name: "Fighting"},
  %{api_id: 5, name: "Shooter"},
  %{api_id: 7, name: "Music"},
  %{api_id: 8, name: "Platform"},
  %{api_id: 9, name: "Puzzle"},
  %{api_id: 10, name: "Racing"},
  %{api_id: 11, name: "Real Time Strategy (RTS)"},
  %{api_id: 12, name: "Role-playing (RPG)"},
  %{api_id: 13, name: "Simulator"},
  %{api_id: 14, name: "Sport"},
  %{api_id: 15, name: "Strategy"},
  %{api_id: 16, name: "Turn-based strategy (TBS)"},
  %{api_id: 24, name: "Tactical"},
  %{api_id: 26, name: "Quiz/Trivia"},
  %{api_id: 25, name: "Hack and slash/Beat 'em up"},
  %{api_id: 30, name: "Pinball"},
  %{api_id: 31, name: "Adventure"},
  %{api_id: 33, name: "Arcade"},
  %{api_id: 34, name: "Visual Novel"},
  %{api_id: 32, name: "Indie"},
  %{api_id: 35, name: "Card & Board Game"},
  %{api_id: 36, name: "MOBA"},
  %{api_id: 2, name: "Point-and-click"}
]
|> Stream.map(&Map.put(&1, :name, String.downcase(&1.name)))
|> Stream.map(&Map.put(&1, :inserted_at, now))
|> Stream.map(&Map.put(&1, :updated_at, now))
|> Enum.to_list()
|> then(&Repo.insert_all(Genre, &1))

# >> Platforms
#
# These are all the platforms in the IGDB database.
# Rather than dynamically inserting them when
# users visit a game listing, they've been
# pulled for seeding instead.
[
  %{
    alternative_name: "Commodore Dynamic Total Vision",
    id: 158,
    name: "Commodore CDTV",
    slug: "commodore-cdtv"
  },
  %{
    alternative_name: "Kids Computer Pico",
    id: 339,
    name: "Sega Pico",
    slug: "sega-pico"
  },
  %{
    abbreviation: "PS2",
    alternative_name: "PS2",
    id: 8,
    name: "PlayStation 2",
    slug: "ps2"
  },
  %{abbreviation: "iOS", id: 39, name: "iOS", slug: "ios"},
  %{abbreviation: "C+4", id: 94, name: "Commodore Plus/4", slug: "c-plus-4"},
  %{id: 144, name: "AY-3-8710", slug: "ay-3-8710"},
  %{
    abbreviation: "odyssey",
    alternative_name: "Magnavox Odyssey; Odysee; Odisea; Odissea",
    id: 88,
    name: "Odyssey",
    slug: "odyssey--1"
  },
  %{abbreviation: "cpet", id: 90, name: "Commodore PET", slug: "cpet"},
  %{id: 237, name: "Sol-20", slug: "sol-20"},
  %{
    abbreviation: "PC",
    alternative_name: "mswin",
    id: 6,
    name: "PC (Microsoft Windows)",
    slug: "win"
  },
  %{alternative_name: "Super Boy", id: 378, name: "Gamate", slug: "gamate"},
  %{abbreviation: "zod", id: 44, name: "Tapwave Zodiac", slug: "zod"},
  %{
    abbreviation: "colecovision",
    id: 68,
    name: "ColecoVision",
    slug: "colecovision"
  },
  %{
    abbreviation: "ti-99",
    alternative_name: "Texas Instruments TI-99/4A",
    id: 129,
    name: "Texas Instruments TI-99",
    slug: "ti-99"
  },
  %{
    alternative_name: "Magnavox Odyssey²",
    id: 133,
    name: "Philips Videopac G7000",
    slug: "philips-videopac-g7000"
  },
  %{id: 134, name: "Acorn Electron", slug: "acorn-electron"},
  %{id: 135, name: "Hyper Neo Geo 64", slug: "hyper-neo-geo-64"},
  %{id: 156, name: "Thomson MO5", slug: "thomson-mo5"},
  %{
    abbreviation: "PlayStation VR",
    id: 165,
    name: "PlayStation VR",
    slug: "playstation-vr"
  },
  %{abbreviation: "Steam VR", id: 163, name: "SteamVR", slug: "steam-vr"},
  %{id: 142, name: "PC-50X Family", slug: "pc-50x-family"},
  %{id: 148, name: "AY-3-8607", slug: "ay-3-8607"},
  %{id: 146, name: "AY-3-8605", slug: "ay-3-8605"},
  %{id: 147, name: "AY-3-8606", slug: "ay-3-8606"},
  %{id: 149, name: "PC-98", slug: "pc-98"},
  %{
    abbreviation: "ACPC",
    alternative_name: "Colour Personal Computer",
    id: 25,
    name: "Amstrad CPC",
    slug: "acpc"
  },
  %{id: 381, name: "Playdate", slug: "playdate"},
  %{
    abbreviation: "fds",
    alternative_name: "Famicom Disk System, FDS",
    id: 51,
    name: "Family Computer Disk System",
    slug: "fds"
  },
  %{
    alternative_name: "WSC",
    id: 123,
    name: "WonderSwan Color",
    slug: "wonderswan-color"
  },
  %{alternative_name: "NGCD", id: 136, name: "Neo Geo CD", slug: "neo-geo-cd"},
  %{
    abbreviation: "Game Gear",
    alternative_name: "GG",
    id: 35,
    name: "Sega Game Gear",
    slug: "gamegear"
  },
  %{abbreviation: "Jaguar", id: 62, name: "Atari Jaguar", slug: "jaguar"},
  %{
    abbreviation: "3DO",
    alternative_name: "3DO",
    id: 50,
    name: "3DO Interactive Multiplayer",
    slug: "3do"
  },
  %{
    abbreviation: "microvision",
    id: 89,
    name: "Microvision",
    slug: "microvision--1"
  },
  %{abbreviation: "DOS", id: 13, name: "PC DOS", slug: "dos"},
  %{
    abbreviation: "supergrafx",
    id: 128,
    name: "PC Engine SuperGrafx",
    slug: "supergrafx"
  },
  %{
    alternative_name: "TG-16CD/PCECD",
    id: 150,
    name: "Turbografx-16/PC Engine CD",
    slug: "turbografx-16-slash-pc-engine-cd"
  },
  %{
    abbreviation: "DC",
    alternative_name: "DC",
    id: 23,
    name: "Dreamcast",
    slug: "dc"
  },
  %{abbreviation: "Atari8bit", id: 65, name: "Atari 8-bit", slug: "atari8bit"},
  %{abbreviation: "vectrex", id: 70, name: "Vectrex", slug: "vectrex"},
  %{abbreviation: "donner30", id: 85, name: "Donner Model 30", slug: "donner30"},
  %{abbreviation: "pdp-8", id: 97, name: "PDP-8", slug: "pdp-8--1"},
  %{abbreviation: "gt40", id: 98, name: "DEC GT40", slug: "gt40"},
  %{
    abbreviation: "microcomputer",
    id: 112,
    name: "Microcomputer",
    slug: "microcomputer--1"
  },
  %{
    abbreviation: "nimrod",
    id: 101,
    name: "Ferranti Nimrod Computer",
    slug: "nimrod"
  },
  %{id: 115, name: "Apple IIGS", slug: "apple-iigs"},
  %{id: 124, name: "SwanCrystal", slug: "swancrystal"},
  %{id: 127, name: "Fairchild Channel F", slug: "fairchild-channel-f"},
  %{id: 125, name: "PC-8801", slug: "pc-8801"},
  %{
    abbreviation: "virtualboy",
    alternative_name: "VB",
    id: 87,
    name: "Virtual Boy",
    slug: "virtualboy"
  },
  %{id: 126, name: "TRS-80", slug: "trs-80"},
  %{
    abbreviation: "Switch",
    alternative_name: "NX",
    id: 130,
    name: "Nintendo Switch",
    slug: "switch"
  },
  %{id: 132, name: "Amazon Fire TV", slug: "amazon-fire-tv"},
  %{id: 138, name: "VC 4000", slug: "vc-4000"},
  %{
    id: 139,
    name: "1292 Advanced Programmable Video System",
    slug: "1292-advanced-programmable-video-system"
  },
  %{id: 155, name: "Tatung Einstein", slug: "tatung-einstein"},
  %{id: 159, name: "Nintendo DSi", slug: "nintendo-dsi"},
  %{
    alternative_name: "NGP",
    id: 119,
    name: "Neo Geo Pocket",
    slug: "neo-geo-pocket"
  },
  %{id: 153, name: "Dragon 32/64", slug: "dragon-32-slash-64"},
  %{id: 154, name: "Amstrad PCW", slug: "amstrad-pcw"},
  %{abbreviation: "XBOX", id: 11, name: "Xbox", slug: "xbox"},
  %{abbreviation: "pdp11", id: 108, name: "PDP-11", slug: "pdp11"},
  %{abbreviation: "VC", id: 47, name: "Virtual Console (Nintendo)", slug: "vc"},
  %{abbreviation: "MSX2", id: 53, name: "MSX2", slug: "msx2"},
  %{
    abbreviation: "Atari7800",
    alternative_name: "Atari 7800 ProSystem",
    id: 60,
    name: "Atari 7800",
    slug: "atari7800"
  },
  %{
    abbreviation: "segacd",
    alternative_name: "Mega CD",
    id: 78,
    name: "Sega CD",
    slug: "segacd"
  },
  %{
    abbreviation: "GBA",
    alternative_name: "GBA",
    id: 24,
    name: "Game Boy Advance",
    slug: "gba"
  },
  %{abbreviation: "Sega32", id: 30, name: "Sega 32X", slug: "sega32"},
  %{id: 140, name: "AY-3-8500", slug: "ay-3-8500"},
  %{id: 143, name: "AY-3-8760", slug: "ay-3-8760"},
  %{id: 145, name: "AY-3-8603", slug: "ay-3-8603"},
  %{
    abbreviation: "N64",
    alternative_name: "N64",
    id: 4,
    name: "Nintendo 64",
    slug: "n64"
  },
  %{
    abbreviation: "NES",
    alternative_name: "NES",
    id: 18,
    name: "Nintendo Entertainment System (NES)",
    slug: "nes"
  },
  %{abbreviation: "Amiga", id: 16, name: "Amiga", slug: "amiga"},
  %{
    alternative_name: "NGPC",
    id: 120,
    name: "Neo Geo Pocket Color",
    slug: "neo-geo-pocket-color"
  },
  %{abbreviation: "WiiU", id: 41, name: "Wii U", slug: "wiiu"},
  %{abbreviation: "x1", id: 77, name: "Sharp X1", slug: "x1"},
  %{
    abbreviation: "browser",
    alternative_name: "Internet",
    id: 82,
    name: "Web browser",
    slug: "browser"
  },
  %{
    abbreviation: "cdccyber70",
    id: 109,
    name: "CDC Cyber 70",
    slug: "cdccyber70"
  },
  %{id: 113, name: "OnLive Game System", slug: "onlive-game-system"},
  %{id: 116, name: "Acorn Archimedes", slug: "acorn-archimedes"},
  %{id: 114, name: "Amiga CD32", slug: "amiga-cd32"},
  %{id: 117, name: "Philips CD-i", slug: "philips-cd-i"},
  %{id: 121, name: "Sharp X68000", slug: "sharp-x68000"},
  %{id: 122, name: "Nuon", slug: "nuon"},
  %{id: 141, name: "AY-3-8610", slug: "ay-3-8610"},
  %{
    abbreviation: "3DS",
    alternative_name: "3DS",
    id: 37,
    name: "Nintendo 3DS",
    slug: "3ds"
  },
  %{
    abbreviation: "Genesis",
    alternative_name: "Sega Genesis",
    id: 29,
    name: "Sega Mega Drive/Genesis",
    slug: "smd"
  },
  %{
    abbreviation: "SMS",
    alternative_name: "SMS",
    id: 64,
    name: "Sega Master System",
    slug: "sms"
  },
  %{
    abbreviation: "GBC",
    alternative_name: "GBC",
    id: 22,
    name: "Game Boy Color",
    slug: "gbc"
  },
  %{
    abbreviation: "PSP",
    alternative_name: "PSP",
    id: 38,
    name: "PlayStation Portable",
    slug: "psp"
  },
  %{
    abbreviation: "turbografx16",
    id: 86,
    name: "TurboGrafx-16/PC Engine",
    slug: "turbografx16--1"
  },
  %{
    abbreviation: "SNES",
    alternative_name: "SNES, Super Nintendo",
    id: 19,
    name: "Super Nintendo Entertainment System (SNES)",
    slug: "snes--1"
  },
  %{abbreviation: "Oculus VR", id: 162, name: "Oculus VR", slug: "oculus-vr"},
  %{id: 308, name: "Playdia", slug: "playdia"},
  %{
    abbreviation: "PS3",
    alternative_name: "PS3",
    id: 9,
    name: "PlayStation 3",
    slug: "ps3"
  },
  %{
    abbreviation: "Mac",
    alternative_name: "Mac OS",
    id: 14,
    name: "Mac",
    slug: "mac"
  },
  %{id: 306, name: "Satellaview", slug: "satellaview"},
  %{
    abbreviation: "Saturn",
    alternative_name: "JVC Saturn, Hi-Saturn, Samsung Saturn, V-Saturn",
    id: 32,
    name: "Sega Saturn",
    slug: "saturn"
  },
  %{
    abbreviation: "Android",
    alternative_name: "Infocusa3",
    id: 34,
    name: "Android",
    slug: "android"
  },
  %{abbreviation: "NGage", id: 42, name: "N-Gage", slug: "ngage"},
  %{
    abbreviation: "Atari5200",
    alternative_name: "Atari 5200 SuperSystem",
    id: 66,
    name: "Atari 5200",
    slug: "atari5200"
  },
  %{
    abbreviation: "intellivision",
    id: 67,
    name: "Intellivision",
    slug: "intellivision"
  },
  %{
    abbreviation: "blackberry",
    id: 73,
    name: "BlackBerry OS",
    slug: "blackberry"
  },
  %{
    alternative_name: "Tricotronic, GW, G&W",
    id: 307,
    name: "Game & Watch",
    slug: "game-and-watch"
  },
  %{
    abbreviation: "imlac-pds1",
    id: 111,
    name: "Imlac PDS-1",
    slug: "imlac-pds1"
  },
  %{id: 118, name: "FM Towns", slug: "fm-towns"},
  %{
    alternative_name: "Nintendo Super Disc",
    id: 131,
    name: "Nintendo PlayStation",
    slug: "nintendo-playstation"
  },
  %{id: 157, name: "NEC PC-6000 Series", slug: "nec-pc-6000-series"},
  %{
    abbreviation: "C64",
    alternative_name: "C64/C128",
    id: 15,
    name: "Commodore C64/128",
    slug: "c64"
  },
  %{alternative_name: "Fujitsu Micro 7", id: 152, name: "FM-7", slug: "fm-7"},
  %{
    abbreviation: "NDS",
    alternative_name: "NDS",
    id: 20,
    name: "Nintendo DS",
    slug: "nds"
  },
  %{abbreviation: "Atari-ST", id: 63, name: "Atari ST/STE", slug: "atari-st"},
  %{
    abbreviation: "Vita",
    alternative_name: "PS Vita",
    id: 46,
    name: "PlayStation Vita",
    slug: "psvita"
  },
  %{
    abbreviation: "PS4",
    alternative_name: "PS4",
    id: 48,
    name: "PlayStation 4",
    slug: "ps4--1"
  },
  %{
    abbreviation: "NGC",
    alternative_name: "GCN",
    id: 21,
    name: "Nintendo GameCube",
    slug: "ngc"
  },
  %{abbreviation: "Lynx", id: 61, name: "Atari Lynx", slug: "lynx"},
  %{
    abbreviation: "C16",
    alternative_name: "C16",
    id: 93,
    name: "Commodore 16",
    slug: "c16"
  },
  %{id: 374, name: "Sharp MZ-2200", slug: "sharp-mz-2200"},
  %{
    abbreviation: "SFAM",
    alternative_name: "SFC",
    id: 58,
    name: "Super Famicom",
    slug: "sfam"
  },
  %{id: 375, name: "Epoch Cassette Vision", slug: "epoch-cassette-vision"},
  %{
    alternative_name: "Samsung Gear VR",
    id: 388,
    name: "Gear VR",
    slug: "gear-vr"
  },
  %{abbreviation: "pdp10", id: 96, name: "PDP-10", slug: "pdp10"},
  %{abbreviation: "Arcade", id: 52, name: "Arcade", slug: "arcade"},
  %{
    alternative_name: "n3DS",
    id: 137,
    name: "New Nintendo 3DS",
    slug: "new-nintendo-3ds"
  },
  %{
    alternative_name: "TV Game",
    id: 377,
    name: "Plug & Play",
    slug: "plug-and-play"
  },
  %{
    alternative_name: "Quest 2",
    id: 386,
    name: "Oculus Quest 2",
    slug: "oculus-quest-2"
  },
  %{abbreviation: "Mobile", id: 55, name: "Legacy Cellphone", slug: "mobile"},
  %{
    abbreviation: "WonderSwan",
    alternative_name: "WS",
    id: 57,
    name: "WonderSwan",
    slug: "wonderswan"
  },
  %{abbreviation: "vic-20", id: 71, name: "Commodore VIC-20", slug: "vic-20"},
  %{
    abbreviation: "Apple][",
    alternative_name: "apple ][",
    id: 75,
    name: "Apple II",
    slug: "appleii"
  },
  %{
    abbreviation: "Win Phone",
    alternative_name: "WP",
    id: 74,
    name: "Windows Phone",
    slug: "winphone"
  },
  %{
    abbreviation: "neogeoaes",
    alternative_name: "AES",
    id: 80,
    name: "Neo Geo AES",
    slug: "neogeoaes"
  },
  %{
    abbreviation: "sg1000",
    alternative_name: "Sega Game 1000",
    id: 84,
    name: "SG-1000",
    slug: "sg1000"
  },
  %{
    alternative_name: "WMR",
    id: 161,
    name: "Windows Mixed Reality",
    slug: "windows-mixed-reality"
  },
  %{
    abbreviation: "neogeomvs",
    alternative_name: "Neo Geo Multi Video System",
    id: 79,
    name: "Neo Geo MVS",
    slug: "neogeomvs"
  },
  %{
    abbreviation: "Game Boy",
    alternative_name: "GB",
    id: 33,
    name: "Game Boy",
    slug: "gb"
  },
  %{
    alternative_name: "YENO Super Cassette Vision",
    id: 376,
    name: "Epoch Super Cassette Vision",
    slug: "epoch-super-cassette-vision"
  },
  %{
    abbreviation: "Wii",
    alternative_name: "Revolution",
    id: 5,
    name: "Wii",
    slug: "wii"
  },
  %{
    alternative_name: "Tiger Game.com",
    id: 379,
    name: "Game.com",
    slug: "game-dot-com"
  },
  %{id: 382, name: "Intellivision Amico", slug: "intellivision-amico"},
  %{
    abbreviation: "Stadia",
    alternative_name: "Stadia",
    id: 170,
    name: "Google Stadia",
    slug: "stadia"
  },
  %{
    abbreviation: "PS5",
    alternative_name: "PS5",
    id: 167,
    name: "PlayStation 5",
    slug: "ps5"
  },
  %{alternative_name: "Go", id: 387, name: "Oculus Go", slug: "oculus-go"},
  %{alternative_name: "Rift", id: 385, name: "Oculus Rift", slug: "oculus-rift"},
  %{
    abbreviation: "astrocade",
    alternative_name: "Bally Arcade",
    id: 91,
    name: "Bally Astrocade",
    slug: "astrocade"
  },
  %{
    alternative_name: "Quest",
    id: 384,
    name: "Oculus Quest",
    slug: "oculus-quest"
  },
  %{
    abbreviation: "bbcmicro",
    alternative_name: "BBC Micro",
    id: 69,
    name: "BBC Microcomputer System",
    slug: "bbcmicro"
  },
  %{
    abbreviation: "Linux",
    alternative_name: "GNU/Linux",
    id: 3,
    name: "Linux",
    slug: "linux"
  },
  %{abbreviation: "Ouya", id: 72, name: "Ouya", slug: "ouya"},
  %{
    abbreviation: "pdp1",
    alternative_name: "Programmed Data Processor-1",
    id: 95,
    name: "PDP-1",
    slug: "pdp1"
  },
  %{
    alternative_name: "Tandy Color Computer",
    id: 151,
    name: "TRS-80 Color Computer",
    slug: "trs-80-color-computer"
  },
  %{
    abbreviation: "analogueelectronics",
    id: 100,
    name: "Analogue electronics",
    slug: "analogueelectronics"
  },
  %{id: 166, name: "Pokémon mini", slug: "pokemon-mini"},
  %{
    abbreviation: "edsac",
    alternative_name: "Electronic Delay Storage Automatic Calculator",
    id: 102,
    name: "EDSAC",
    slug: "edsac--1"
  },
  %{abbreviation: "hp2100", id: 104, name: "HP 2100", slug: "hp2100"},
  %{id: 236, name: "Exidy Sorcerer", slug: "exidy-sorcerer"},
  %{abbreviation: "pdp-7", id: 103, name: "PDP-7", slug: "pdp-7--1"},
  %{
    alternative_name: "Digital Versatile Disc Player",
    id: 238,
    name: "DVD Player",
    slug: "dvd-player"
  },
  %{abbreviation: "hp3000", id: 105, name: "HP 3000", slug: "hp3000"},
  %{abbreviation: "sdssigma7", id: 106, name: "SDS Sigma 7", slug: "sdssigma7"},
  %{id: 164, name: "Daydream", slug: "daydream"},
  %{
    abbreviation: "call-a-computer",
    id: 107,
    name: "Call-A-Computer time-shared mainframe computer system",
    slug: "call-a-computer"
  },
  %{id: 240, name: "Zeebo", slug: "zeebo"},
  %{
    abbreviation: "plato",
    alternative_name: "Programmed Logic for Automatic Teaching Operations",
    id: 110,
    name: "PLATO",
    slug: "plato--1"
  },
  %{id: 239, name: "Blu-ray Player", slug: "blu-ray-player"},
  %{abbreviation: "ZXS", id: 26, name: "ZX Spectrum", slug: "zxs"},
  %{id: 274, name: "PC-FX", slug: "pc-fx"},
  %{abbreviation: "MSX", id: 27, name: "MSX", slug: "msx"},
  %{id: 309, name: "Evercade", slug: "evercade"},
  %{id: 372, name: "OOParts", slug: "ooparts"},
  %{
    alternative_name: "ZX81",
    id: 373,
    name: "Sinclair ZX81",
    slug: "sinclair-zx81"
  },
  %{id: 203, name: "DUPLICATE Stadia", slug: "duplicate-stadia"},
  %{
    alternative_name: "Loopy",
    id: 380,
    name: "Casio Loopy",
    slug: "casio-loopy"
  },
  %{
    abbreviation: "Series X",
    alternative_name: "XSX",
    id: 169,
    name: "Xbox Series X|S",
    slug: "series-x"
  },
  %{
    abbreviation: "Atari2600",
    alternative_name: "Atari VCS",
    id: 59,
    name: "Atari 2600",
    slug: "atari2600"
  },
  %{
    abbreviation: "X360",
    alternative_name: "X360",
    id: 12,
    name: "Xbox 360",
    slug: "xbox360"
  },
  %{
    abbreviation: "XONE",
    alternative_name: "XONE",
    id: 49,
    name: "Xbox One",
    slug: "xboxone"
  },
  %{
    abbreviation: "PS1",
    alternative_name: "PSX, PSOne, PS",
    id: 7,
    name: "PlayStation",
    slug: "ps"
  },
  %{
    abbreviation: "famicom",
    alternative_name: "Famicom",
    id: 99,
    name: "Family Computer",
    slug: "famicom"
  },
  %{id: 389, name: "AirConsole", slug: "airconsole"},
  %{
    alternative_name: "PSVR2",
    id: 390,
    name: "PlayStation VR2",
    slug: "playstation-vr2"
  }
]
|> Stream.map(&Map.put(&1, :api_id, &1.id))
|> Stream.map(fn map ->
  if Map.get(map, :abbreviation) do
    Map.put(map, :abbreviation, String.downcase(map.abbreviation))
  else
    map
  end
end)
|> Stream.map(&Map.put(&1, :inserted_at, now))
|> Stream.map(&Map.put(&1, :updated_at, now))
|> Stream.map(&Map.drop(&1, [:id]))
|> Enum.to_list()
|> then(&Repo.insert_all(Platform, &1))
