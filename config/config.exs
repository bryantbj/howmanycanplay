# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :howmanycanplay,
  ecto_repos: [Howmanycanplay.Repo]

# Configures the endpoint
config :howmanycanplay, HowmanycanplayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kdLpRZ0DtujBqApU81wt07mKKUw3N1yvORta0xw+rAKtMZPwo6dt+KebeqVmWOgj",
  render_errors: [view: HowmanycanplayWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Howmanycanplay.PubSub,
  live_view: [signing_salt: "p76wTOVm"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
