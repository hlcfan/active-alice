defmodule Alice.Handlers.Random do
  use Alice.Router

  # Routes

  route ~r/\bbig ?data\b/i,                                :big_data
  route ~r/\bcocaine\b/i,                                  :cocaine
  route ~r/\bdemeter\b/i,                                  :say_demeter_again
  route ~r/\bgrapes\b/i,                                   :fuck_yo_grapes
  route ~r/\bbusted\b/i,                                   :busted
  route ~r/\bdev[- ]?ops\b/i,                              :devops
  route ~r/\bIT IS DECIDED\!?\b/,                          :it_is_decided
  route ~r/\bmadness\b/i,                                  :this_is_sparta
  route ~r/\bwat\b/i,                                      :wat
  route ~r/\bmind blown\b/i,                               :mind_blown
  route ~r/\bthanks,? alice\b/i,                           :thanks
  command ~r/thanks/i,                                     :thanks
  route ~r/\b(a+w+ ?y+i+s+|bread ?crumbs)!*\b/i,           :aww_yiss
  route ~r/\bdark ?souls?\b/i,                             :i_dont_care
  route ~r/\bgames?\b/i,                                   :the_game
  route ~r/\bI (love|:heart:) you,? alice\b/i,             :alice_love
  route ~r/\balice,? I (love|:heart:) you\b/i,             :alice_love
  command ~r/\bI (love|:heart:) you\b/i,                   :alice_love
  command ~r/\bdie\z/i,                                    :die
  route ~r/\bmic ?drop\b/i,                                :mic_drop
  route ~r/\bdrop ?(the)? ?mic\b/i,                        :mic_drop
  route ~r/\bclear ?(your)? ?cache\??\b/i,                 :cache_bug
  route ~r/\b(dis|this)( is)? gon(na)? be? g(u|oo)d\b/i,   :dis_gon_b_gud
  route ~r/\b(wub ?(wub)?|dub(step)?|d+rop.*bas(s|e))\b/i, :dddddrop_the_bass
  route ~r/\b(mad|angry|rage)\b/i,                         :u_mad_bro
  route ~r/\bno+pe+\b/i,                                   :nope_nope_nope
  route ~r/\bgooo+d\b/i,                                   :goooood
  route ~r/\b(ha(ha)+|lol)\b/i,                            :haha
  route ~r/\bto+t(ally|es)\b/i,                            :toooootally

  @doc "`big data`/`bigdata` - BIG data"
  def big_data(conn), do: "http://i.imgur.com/U6m4s4o.jpg" |> reply(conn)

  @doc "`cocaine` - ba ba da ba ba da cocaine!"
  def cocaine(conn), do: "http://i.imgur.com/A3QICEQ.gif" |> reply(conn)

  @doc "`demeter` - try me"
  def say_demeter_again(conn), do: "http://i.imgur.com/Z0jvLNm.jpg" |> reply(conn)

  @doc "`grapes` - your grapes, fuck 'em"
  def fuck_yo_grapes(conn), do: "http://i.imgur.com/v4y3BLl.gif" |> reply(conn)

  @doc "`busted` - get busted by Mr. Biggs"
  def busted(conn), do: "http://i.imgur.com/MasM57I.png" |> reply(conn)

  @doc "`devops`/`dev-ops`/`dev ops` - ops problem now!"
  def devops(conn), do: "http://i.imgur.com/6sNQ3yt.jpg" |> reply(conn)

  @doc "`IT IS DECIDED` - nail that decision coffin"
  def it_is_decided(conn), do: "http://i.imgur.com/80PQSCo.gif" |> reply(conn)

  @doc "`mind blown` - blow your mind"
  def mind_blown(conn), do: "http://i.imgur.com/lr4KJPQ.gif" |> reply(conn)

  @doc "`this is <anything>` - THIS IS SPARTA"
  def this_is_sparta(conn), do: "http://i.imgur.com/ydJ3Vcr.jpg" |> reply(conn)

  @doc "`wat` - wat"
  def wat(conn), do: "http://i.imgur.com/IppKJ.jpg"   |> reply(conn)

  @doc "Either `thanks alice` or `@alice thanks` - tell Alice thanks"
  def thanks(conn), do: "no prob, bob" |> reply(conn)

  @doc "`aww yiss`/`bread crumbs` - motha fuckin' bread crumbs"
  def aww_yiss(conn), do: "http://i.imgur.com/SEQTUr3.jpg" |> reply(conn)

  @doc "`dark souls` - find out just how much Alice cares about Dark Souls"
  def i_dont_care(conn), do: "http://i.imgur.com/29A4xj5.gif" |> reply(conn)

  def the_game(conn=%Alice.Conn{message: %{channel: channel}}) do
    :calendar.universal_time
    |> :calendar.datetime_to_gregorian_seconds
    |> game_response(get_state(conn, {:next_loss, channel}, 0), conn)
  end

  defp game_response(now, next_loss, conn) when now < next_loss, do: conn
  defp game_response(now, _, conn=%Alice.Conn{message: %{channel: channel}}) do
    conn
    |> put_state({:next_loss, channel}, now + (30*60))
    |> chance_reply(0.25, "http://i.imgur.com/Z8awIpt.png", "I lost the game")
  end

  @doc """
  Express some love for Alice
      `I love you alice`
      `I `:heart:` you, alice`
      `alice, I love`/:heart:` you`
      `@alice I love`/:heart:` you`
  """
  def alice_love(conn) do
    [love|_rest] = conn.message.captures |> Enum.reverse
    emoji = Enum.random(~w[:wink: :heart_eyes: :kissing_heart: :hugging_face:])
    "aww, I #{love} you too, #{Alice.Conn.at_reply_user(conn)}! #{emoji}" |> reply(conn)
  end

  @doc "`die` - request that Alice die. You might not like the response"
  def die(conn) do
    delayed_reply("go fuck yourself", 1200, conn)
    reply("hey #{Alice.Conn.at_reply_user(conn)}...", conn)
  end

  @doc "`mic drop` - drop the mic"
  def mic_drop(conn) do
    ~w[http://i.imgur.com/MpEqxwM.gif
      http://i.imgur.com/YANYG8d.gif
      http://i.imgur.com/ZxZUyH9.gif
      http://i.imgur.com/9XVQlvS.gif
      http://i.imgur.com/XTWiamq.gif
      http://i.imgur.com/3hkSF89.gif]
    |> random_reply(conn)
  end

  @doc "`clear your cache` - you may have a cache bug if..."
  def cache_bug(conn) do
    ~w[http://i.imgur.com/mus48mo.jpg
      http://i.imgur.com/Mt669js.png
      http://i.imgur.com/OzI9RZq.jpg]
    |> random_reply(conn)
  end

  @doc "`dis gon b gud`/`this is gonna to be good` - sit back and enjoy the show"
  def dis_gon_b_gud(conn) do
    ~w[http://i.imgur.com/j7PKhl1.gif
      http://i.imgur.com/mtHKey3.gif
      http://i.imgur.com/uh5A6.gif
      http://i.imgur.com/o3o1fU3.gif]
    |> random_reply(conn)
  end

  @doc """
  Epic Bass Drop Time
      `dddddddrop the bass`
      `wub wub`
      `dubstep`
  """
  def dddddrop_the_bass(conn) do
    ~w[http://s3-ec.buzzfed.com/static/enhanced/webdr03/2013/2/15/9/anigif_enhanced-buzz-27236-1360939858-5.gif
      http://s3-ec.buzzfed.com/static/enhanced/webdr01/2013/2/15/9/anigif_enhanced-buzz-5139-1360939681-14.gif
      http://s3-ec.buzzfed.com/static/enhanced/webdr02/2013/2/15/11/enhanced-buzz-3235-1360947432-2.jpg
      http://i1212.photobucket.com/albums/cc460/bbtlv/dubstep.gif
      http://i.imgur.com/kUtovs7.gif]
    |> random_reply(conn)
  end

  @doc "`mad`/`angry`/`rage` - u mad bro?"
  def u_mad_bro(conn) do
    ~w[http://24.media.tumblr.com/e48acd4c34a62200a81df7259ab31d57/tumblr_n2kygg41US1rzgx44o1_400.gif
      http://i1248.photobucket.com/albums/hh490/Andrea2awesome/internet-memes-y-u-mad-tho.jpg
      http://i.imgur.com/KEh9WOT.png]
    |> random_reply(conn)
  end

  @doc "`nope` - nope nope nope"
  def nope_nope_nope(conn) do
    ~w[http://i.imgur.com/ZG8Y5XQ.gif
      http://i.imgur.com/Bebd11u.gif
      http://i.imgur.com/piqluC8.jpg
      http://i.imgur.com/UUoYZjM.jpg
      http://i.imgur.com/oQsSbYC.gif
      http://i.imgur.com/HIN4HrI.gif
      http://i.imgur.com/yBE4JbR.jpg
      http://i.imgur.com/DgczUtV.png]
    |> random_reply(conn)
  end

  @doc "`goood` - embrace your hate"
  def goooood(conn) do
    ~w[http://i.imgur.com/1jtr4HM.png
      http://i.imgur.com/j83QRp7.png
      http://i.imgur.com/rm8NcQC.jpg
      http://i.imgur.com/nmC7Hnb.jpg]
    |> random_reply(conn)
  end

  @doc "`totally` - totes magotes"
  def toooootally(conn) do
    chance_reply(conn, 0.2, "http://i.imgur.com/XuTdELg.jpg", generate_totally)
  end

  defp generate_totally, do: "to#{String.duplicate("o", Enum.random(0..9))}tally"

  @doc "😂"
  def haha(conn) do
    conn
    |> get_state(:haha_count, 0)
    |> case do
      93 ->
        conn
        |> put_state(:haha_count, 0)
        |> reply("https://s3.amazonaws.com/giphymedia/media/Ic97mPViHEG5O/giphy.gif")
      count -> put_state(conn, :haha_count, count + 1)
    end
  end
end
