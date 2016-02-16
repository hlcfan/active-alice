use Mix.Config

config :alice_google_images,
  cse_id: System.get_env("GOOGLE_CSE_ID"),
  cse_token: System.get_env("GOOGLE_CSE_TOKEN"),
  safe_search_level: :medium

case Mix.env do
  env when env in [:prod, :dev] -> import_config "#{env}.exs"
  _other                        -> import_config "other.exs"
end
