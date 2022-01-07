defmodule Twitch do
  use HTTPoison.Base

  @endpoint "https://id.twitch.tv"

  def client_id(), do: "qljjnncbh40njh7708lsw8u09329nc"
  def client_secret(), do: "qnb8os26pgkw1gwtdmoauk9onu1s5b"

  def process_url(url), do: @endpoint <> url
  def process_response_body(binary), do: Jason.decode!(binary)

  def get_token() do
    url =
      "/oauth2/token" <>
        "?client_id=#{client_id()}" <>
        "&client_secret=#{client_secret()}" <>
        "&grant_type=client_credentials" <>
        "&scope=analytics:read:games"

    %{body: %{"access_token" => token, "expires_in" => expires_in}} = post!(url, "")

    Cachex.put_many(:cache, [
      {"twitch/token/token", token},
      {"twitch/token/expires_at", DateTime.utc_now() |> DateTime.add(expires_in)}
    ])

    token
  end

  def token() do
    case Cachex.get(:cache, "twitch/token/token") do
      {:ok, nil} -> get_token()
      {:ok, token} -> token
      _ -> get_token()
    end
  end
end
