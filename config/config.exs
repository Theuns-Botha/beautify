# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :beautify,
  ecto_repos: [Beautify.Repo]

# Configures the endpoint
config :beautify, Beautify.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "F0sYr1sgU/EyfoYxCdyTsxe6ujF3BHwwKP3aZmcoDZ0FapqGpSJLD4Zg+kooNSV5",
  render_errors: [view: Beautify.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Beautify.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "Beautify.#{Mix.env}",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: Beautify.GuardianSerializer,
  secret_key: to_string(Mix.env) <> "SuPerseCret_aBraCadabrA"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
