# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :we_need_to_watch,
  ecto_repos: [WeNeedToWatch.Repo]

# Configures the endpoint
config :we_need_to_watch, WeNeedToWatchWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8xmq+fAhHcJMV2aTRO3B03wDWaph9Ce/wZDcNjHRfSotqm7EwD+w6ce+dFh8LpjD",
  render_errors: [view: WeNeedToWatchWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WeNeedToWatch.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :we_need_to_watch, :basic_auth,
  username: "watch",
  password: "movies"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Override with local configuration (gitignored)
import_config "local.exs"
