defmodule ShortUrl.ShortUrls do
  @moduledoc """
  The ShortUrls context.
  """

  import Ecto.Query, warn: false
  alias ShortUrl.Repo

  alias ShortUrl.ShortUrls.Url

  @max_attempts 5

  def get_url_by_short_key(short_key) do
    Repo.get_by(Url, short_key: short_key)
  end

  def get_url_by_url(url) do
    Repo.get_by(Url, url: url)
  end

  def create_url(attrs \\ %{}) do
    # First check if the url was already used and and return that one
    case get_url_by_url(attrs["url"]) do
      %Url{} = existing_url ->
        {:ok, existing_url}

      nil ->
        create_url_with_unique_short_key(attrs, attempts: @max_attempts)
    end
  end

  defp create_url_with_unique_short_key(attrs, attempts: attempts) when attempts > 0 do
    short_key = generate_short_key()

    if get_url_by_short_key(short_key) do
      create_url_with_unique_short_key(attrs, attempts: attempts - 1)
    else
      attrs = Map.put(attrs, "short_key", short_key)

      %Url{}
      |> Url.changeset(attrs)
      |> Repo.insert()
    end
  end

  defp create_url_with_unique_short_key(_attrs, attempts: 0) do
    # Raise an exception after too many failed attempts
    raise "Failed to generate a unique short key after multiple attempts"
  end

  defp generate_short_key do
    key_length = 6

    for _ <- 1..key_length do
      case :rand.uniform(2) do
        # 48-57 -> 0-9
        1 -> :rand.uniform(10) + 47
        # 97-122 -> a-z
        2 -> :rand.uniform(26) + 96
      end
    end
    |> to_string()
  end
end
