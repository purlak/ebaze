use Mix.Config

config :ebaze,
  ecto_repos: [Ebaze.Repo]

config :ebaze, EbazeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9Jtl1EW7uCEveXrKxtUm9r4h3xMFovB+xA8UQA5Np2KsLUuSEI/8OhK0LAs7Kgc0",
  render_errors: [view: EbazeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ebaze.PubSub, adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"

config :ebaze, Ebaze.Accounts.Guardian,
  issuer: "ebaze",
  secret_key: "bRFrRapuJwzN0laF4BbhJrCbvHtQzJjhsWHTpzANgRZw4NMTUCKtXJ+os7m9OC53"
