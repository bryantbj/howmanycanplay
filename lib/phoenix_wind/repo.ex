defmodule PhoenixWind.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_wind,
    adapter: Ecto.Adapters.Postgres
end
