# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ebaze,
  ecto_repos: [Ebaze.Repo]

# Configures the endpoint
config :ebaze, EbazeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9Jtl1EW7uCEveXrKxtUm9r4h3xMFovB+xA8UQA5Np2KsLUuSEI/8OhK0LAs7Kgc0",
  render_errors: [view: EbazeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ebaze.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
