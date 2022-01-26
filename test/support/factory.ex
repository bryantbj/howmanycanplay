defmodule Howmanycanplay.Factory do
  use ExMachina.Ecto, repo: Howmanycanplay.Repo

  alias Howmanycanplay.{
    Games.Game,
    Genres.Genre,
    Genres.GameGenre,
    ApiGame,
    Games.GameMode,
    Games.GameGameMode
  }

  def game_factory(attrs \\ %{}) do
    %Game{
      api_id: sequence(:game_api_id, & &1),
      name: sequence(:name, &"Game #{&1}"),
      summary: sequence(:summary, &"Game summary #{&1}")
    }
    |> Map.merge(attrs)
  end

  def game_mode_factory(attrs \\ %{}) do
    %GameMode{
      name: sequence(:game_mode, &"Game Mode #{&1}")
    }
    |> Map.merge(attrs)
  end

  def game_game_mode_factory(attrs \\ %{}) do
    %GameGameMode{
      game: build(:game),
      game_mode: build(:game_mode)
    }
    |> Map.merge(attrs)
  end

  def genre_factory(attrs \\ %{}) do
    %Genre{
      name: sequence(:name, &"Genre #{&1}")
    }
    |> Map.merge(attrs)
  end

  def game_genre_factory(attrs \\ %{}) do
    %GameGenre{
      game: build(:game),
      genre: build(:genre)
    }
    |> Map.merge(attrs)
  end

  def api_game_factory(attrs \\ %{}) do
    name = sequence(:api_game_name, &"ApiGame #{&1}")
    api_id = sequence(:api_game_api_id, & &1)

    %ApiGame{
      api_id: api_id,
      id: api_id,
      cover_url: "//images.igdb.com/igdb/image/upload/t_cover_big_2x/co1rcb.jpg",
      follows: nil,
      game_modes: ["Multiplayer"],
      genres: ["Shooter", "Strategy"],
      multiplayer_modes: [
        %{
          campaigncoop: false,
          checksum: "bf75bd66-0d2f-c6ca-a01c-c5b8ef5a39f5",
          dropin: true,
          game: 8173,
          id: 7838,
          lancoop: false,
          offlinecoop: false,
          offlinecoopmax: 0,
          offlinemax: 0,
          onlinecoop: true,
          onlinecoopmax: 6,
          onlinemax: 12,
          platform: %{abbreviation: "PC", name: "PC (Microsoft Windows)"},
          splitscreen: false
        },
        %{
          campaigncoop: false,
          checksum: "4d84b82a-9cab-4bfd-9d0d-86dc0bb66f62",
          dropin: true,
          game: 8173,
          id: 7839,
          lancoop: false,
          offlinecoop: false,
          onlinecoop: true,
          onlinecoopmax: 6,
          onlinemax: 12,
          platform: %{abbreviation: "XONE", name: "Xbox One"},
          splitscreen: false
        },
        %{
          campaigncoop: false,
          checksum: "0a445a25-5e34-d012-89cb-9dc7a6869b62",
          dropin: true,
          game: 8173,
          id: 7840,
          lancoop: false,
          offlinecoop: false,
          onlinecoop: true,
          onlinecoopmax: 6,
          onlinemax: 12,
          platform: %{abbreviation: "PS4", name: "PlayStation 4"},
          splitscreen: false
        }
      ],
      name: name,
      onlinecoopmax: 6,
      platforms: [
        %{abbreviation: "PC", name: "PC (Microsoft Windows)"},
        %{abbreviation: "PS4", name: "PlayStation 4"},
        %{abbreviation: "XONE", name: "Xbox One"},
        %{abbreviation: "Switch", name: "Nintendo Switch"}
      ],
      release_dates: [],
      summary:
        "In #{name}, you control one of several heroes in competitive 6-person team shooting matches. Battle over objectives, take down the other team, and achieve victory.\n\nIn Overwatch, heroes do battle in diverse locations around the world. From the technological marvel of Numbani to the manufacturing powerhouse of Volskaya, each map has a unique layout and specific win conditions that your team must meet in order to secure victory.",
      thumb_url: "//images.igdb.com/igdb/image/upload/t_cover_big/co1rcb.jpg",
      year_released: nil
    }
    |> Map.merge(attrs)
  end

  def api_game_http_factory(attrs \\ %{id: 9_898_989}) do
    {:ok,
     %HTTPoison.Response{
       body: [
         %{
           name: "Game #{attrs.id}",
           result: [
             %{
               cover: %{
                 id: 82091,
                 image_id: "co1rcb",
                 url: "//images.igdb.com/igdb/image/upload/t_thumb/co1rcb.jpg"
               },
               game_modes: [
                 %{
                   checksum: "288b548c-11e4-d910-f037-21d4e6a33b38",
                   created_at: 1_298_937_600,
                   id: 2,
                   name: "Multiplayer",
                   slug: "multiplayer",
                   updated_at: 1_323_216_000,
                   url: "https://www.igdb.com/game_modes/multiplayer"
                 }
               ],
               genres: [%{id: 5, name: "Shooter"}, %{id: 15, name: "Strategy"}],
               id: attrs.id,
               multiplayer_modes: [
                 %{
                   campaigncoop: false,
                   checksum: "bf75bd66-0d2f-c6ca-a01c-c5b8ef5a39f5",
                   dropin: true,
                   game: 8173,
                   id: 7838,
                   lancoop: false,
                   offlinecoop: false,
                   offlinecoopmax: 0,
                   offlinemax: 0,
                   onlinecoop: true,
                   onlinecoopmax: 6,
                   onlinemax: 12,
                   platform: 6,
                   splitscreen: false
                 },
                 %{
                   campaigncoop: false,
                   checksum: "4d84b82a-9cab-4bfd-9d0d-86dc0bb66f62",
                   dropin: true,
                   game: 8173,
                   id: 7839,
                   lancoop: false,
                   offlinecoop: false,
                   onlinecoop: true,
                   onlinecoopmax: 6,
                   onlinemax: 12,
                   platform: 49,
                   splitscreen: false
                 },
                 %{
                   campaigncoop: false,
                   checksum: "0a445a25-5e34-d012-89cb-9dc7a6869b62",
                   dropin: true,
                   game: 8173,
                   id: 7840,
                   lancoop: false,
                   offlinecoop: false,
                   onlinecoop: true,
                   onlinecoopmax: 6,
                   onlinemax: 12,
                   platform: 48,
                   splitscreen: false
                 }
               ],
               name: "Overwatch",
               platforms: [
                 %{abbreviation: "PC", id: 6, name: "PC (Microsoft Windows)"},
                 %{abbreviation: "PS4", id: 48, name: "PlayStation 4"},
                 %{abbreviation: "XONE", id: 49, name: "Xbox One"},
                 %{abbreviation: "Switch", id: 130, name: "Nintendo Switch"}
               ],
               summary:
                 "In Overwatch, you control one of several heroes in competitive 6-person team shooting matches. Battle over objectives, take down the other team, and achieve victory.\n\nIn Overwatch, heroes do battle in diverse locations around the world. From the technological marvel of Numbani to the manufacturing powerhouse of Volskaya, each map has a unique layout and specific win conditions that your team must meet in order to secure victory."
             }
           ]
         }
       ],
       headers: [
         {"Date", "Sat, 22 Jan 2022 01:23:35 GMT"},
         {"Content-Type", "application/json;charset=utf-8"},
         {"Transfer-Encoding", "chunked"},
         {"Connection", "keep-alive"},
         {"x-amzn-RequestId", "ae3d2117-faf2-460c-bdb9-26d8d1f21436"},
         {"x-amzn-Remapped-Content-Length", "935"},
         {"x-amz-apigw-id", "MUtnmGkhvHcFh2Q="},
         {"x-amzn-Remapped-Server", "Javalin"},
         {"x-amzn-Remapped-Date", "Sat, 22 Jan 2022 01:23:35 GMT"},
         {"X-Cache", "Miss from cloudfront"},
         {"Via", "1.1 f37f104903bda438e8b0547be6e0c192.cloudfront.net (CloudFront)"},
         {"X-Amz-Cf-Pop", "IAD89-C3"},
         {"X-Amz-Cf-Id", "BhBayTcExhTr4LSOnzWYgKGfLXmIEpgcVIf31ewTu_x8DdSsqyOruA=="},
         {"CF-Cache-Status", "DYNAMIC"},
         {"Expect-CT",
          "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""},
         {"Strict-Transport-Security", "max-age=15552000; includeSubDomains; preload"},
         {"X-Content-Type-Options", "nosniff"},
         {"Server", "cloudflare"},
         {"CF-RAY", "6d14fa4d9c3063bd-ATL"}
       ],
       request: %HTTPoison.Request{
         body:
           "query games \"Game #{attrs.id}\" {\n  fields id,name,summary,cover.url,cover.image_id,genres.name,multiplayer_modes.*,platforms.name,platforms.abbreviation,game_modes.name,game_modes.*;\n  where id = 8173;\n  limit 1;\n};\n",
         headers: [
           "Client-ID": "",
           Authorization: ""
         ],
         method: :post,
         options: [],
         params: %{},
         url: "https://api.igdb.com/v4/multiquery"
       },
       request_url: "https://api.igdb.com/v4/multiquery",
       status_code: 200
     }}
  end
end
