use Mix.Config

config :alice,
  api_key: System.get_env("LAASY_SLACK_KEY"),
  state_backend: :redis,
  redis: "redis://localhost"

config :logger,
  level: :info,
  truncate: 32_768
