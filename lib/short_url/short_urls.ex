defmodule ShortUrl.ShortUrls do
  @moduledoc """
  The ShortUrls context.
  """

  import Ecto.Query, warn: false
  alias ShortUrl.Repo

  alias ShortUrl.ShortUrls.Url

  def get_url_by_short_key(short_key) do
    Repo.get_by(Url, short_key: short_key)
  end

  def get_url_by_url(url) do
    Repo.get_by(Url, url: url)
  end

  @doc """
  Creates a url.

  ## Examples

      iex> create_url(%{field: value})
      {:ok, %Url{}}

      iex> create_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_url(attrs \\ %{}) do
    case get_url_by_url(attrs["url"]) do
      %Url{} = existing_url ->
        {:ok, existing_url}

      nil ->
        attrs = Map.put(attrs, "short_key", generate_short_key())

        %Url{}
        |> Url.changeset(attrs)
        |> Repo.insert()
    end
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
