# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# config for slack
# api_token [required] : Enter your app token. 
#                        If you do not have a token, please get it from https://api.slack.com/custom-integrations/legacy-tokens
# channel   [required] : Channel name to post github trend
# option               : Other options
#                        ex) %{username: "itHub Trend Bot', icon_emoji: ""}
#                        find more detailed information the https://api.slack.com/methods/chat.postMessage
config :slack,
  api_token: "enter your app token",
  channel: "enter channel name",
  option: %{username: "GitHub Trend Bot"}

# quantum config 
# More details https://github.com/c-rack/quantum-elixir
config :quantum, GithubTrendBot.Scheduler,
  jobs: [
    {"0 * * * *", {GithubTrendBot, :post_trend, []}}
  ]
