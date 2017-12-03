defmodule GithubTrendBot do
  @moduledoc """
  Documentation for GithubTrendBot.
  """

  def post_trend do
    attachments = 
      GithubTrendBot.Trending.fetch_today_trending
      |> process_attachment
      |> Poison.encode!

    channel = Application.get_env(:slack, :channel, "")

    Slack.Web.Chat.post_message(channel, "", option(attachments))

  end

  defp process_attachment([], acc), do: acc
  defp process_attachment([h|t], acc \\ []) do
    {repo_name, repo_link, description, language, language_color,  total_stars, today_stars} = h

    _attachment = %{
      color: language_color,
      title: repo_name,
      title_link: repo_link,
      text: description,
      fields: [
        %{
          value: ":star: #{total_stars} / #{today_stars}"
        }
      ]
    }

    attachment = case language do
                   "" -> _attachment
                   _  ->
                     language_field = %{value: ":memo: #{language}"}
                     %{_attachment | fields: [language_field | _attachment.fields]}
                end

    process_attachment(t, [attachment | acc ])
  end

  defp option(attachments) do
    case Application.get_env(:slack, :option) do
      option when is_map(option) -> Map.merge(%{attachments: attachments}, option)
      _ -> %{attachments: attachments}
    end
  end

end
