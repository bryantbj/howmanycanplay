defmodule Howmanycanplay.Repo do
  use Ecto.Repo,
    otp_app: :howmanycanplay,
    adapter: Ecto.Adapters.Postgres
end
