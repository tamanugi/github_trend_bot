defmodule GithubTrendBot.Trending do

  @github_url "https://github.com"
  @github_trend_url @github_url <> "/trending"

  def today_trending do

    %HTTPoison.Response{body: body} = HTTPoison.get! @github_trend_url

    body
    |> Floki.find("li[id^=pa]")
    |> Enum.map(fn repo -> parse_pa(repo) end)

  end

  defp parse_pa(pa) do
    repo_link = pa
    |> Floki.find("h3 a")
    |> Floki.attribute("href")
    |> List.first

    "/" <> repo_name = repo_link

    description = pa
    |> Floki.find("div.py-1")
    |> Floki.text
    |> String.trim

    language = pa
    |> Floki.find("[itemprop=programmingLanguage]")
    |> Floki.text
    |> String.trim

    total_stars = pa
    |> Floki.find("a[href$=stargazers]")
    |> Floki.text
    |> String.trim

    today_stars = pa
    |> Floki.find("span")
    |> Enum.map(fn e -> e |> Floki.text |> String.trim end)
    |> filter_today_stars

    {repo_name, @github_url <> repo_link, description, language, total_stars, today_stars}

  end

  defp filter_today_stars([h | t]) do
    case Regex.match?(~r/\d* stars today/, h) do
      true -> h
      _ -> filter_today_stars(t)
    end
  end

  defp filter_today_stars(_), do: ""
end
