defmodule ActiveAlice.Mixfile do
  use Mix.Project

  def project do
    [ app: :active_alice,
      version: "0.3.0",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps() ]
  end

  def application do
    [
      applications: [:alice],
      mod: {Alice, %{handlers: handlers()}}
    ]
  end

  defp handlers do
    [
      Alice.Handlers.Random,
      Alice.Handlers.OhYouSo,
      Alice.Handlers.GoogleImages,
      Alice.Handlers.Karma,
      Alice.Handlers.Shizzle,
      Alice.Handlers.Wiki,
      Alice.Handlers.Xkcd,
      Alice.Handlers.Dogeme,
      Alice.Handlers.Eats
    ]
  end

  defp deps do
     [
       {:alice, github: "alice-bot/alice", branch: "master", override: true},
       # {:alice,               "~> 0.3"},
       {:alice_google_images, "~> 0.1"},
       {:alice_karma,         "~> 0.1"},
       {:alice_shizzle,       "~> 0.1"},
       {:alice_wiki,          "~> 1.0"},
       {:alice_xkcd,          "~> 0.0.5"},
       {:alice_doge_me,       "~> 0.1"},
       {:alice_eats,          "~> 0.1"}
     ]
  end
end
