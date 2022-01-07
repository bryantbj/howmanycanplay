defmodule Howmanycanplay.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Howmanycanplay.Repo,
      # Start the Telemetry supervisor
      HowmanycanplayWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Howmanycanplay.PubSub},
      # Start the Endpoint (http/https)
      HowmanycanplayWeb.Endpoint,
      # Start a worker by calling: Howmanycanplay.Worker.start_link(arg)
      # {Howmanycanplay.Worker, arg}
      %{id: Cachex, start: {Cachex, :start_link, [[name: :cache]]}},
      %{id: :cachex_igdb, start: {Cachex, :start_link, [[name: :igdb]]}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Howmanycanplay.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HowmanycanplayWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
