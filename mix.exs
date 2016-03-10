defmodule ActiveAlice.Mixfile do
  use Mix.Project

  def project do
    [ app: :active_alice,
      version: "0.2.0",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps ]
  end

  def application do
    [ applications: [:alice],
      mod: {
        Alice, [
          Alice.Handlers.Random,
          Alice.Handlers.OhYouSo,
          Alice.Handlers.GoogleImages,
          Alice.Handlers.Karma,
          Alice.Handlers.Shizzle,
          Alice.Handlers.Xkcd
        ] } ]
  end

  defp deps do
     [
       {:websocket_client, github: "jeremyong/websocket_client"},
       # {:alice, path: "~/projects/alice/alice"}
       {:alice,                  "~> 0.2.3"},
       {:alice_google_images,    "~> 0.1.1"},
       {:alice_karma,            "~> 0.1.0"},
       {:alice_shizzle,          "~> 0.1.1"},
       {:alice_xkcd,             "~> 0.0.1"}
     ]
  end
end
