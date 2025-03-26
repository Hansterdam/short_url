defmodule ShortUrl.ShortUrls do
  @moduledoc """
  The ShortUrls context.
  """

  import Ecto.Query, warn: false
  alias ShortUrl.Repo

  alias ShortUrl.ShortUrls.Url

  @doc """
  Gets a single url.

  Raises `Ecto.NoResultsError` if the Url does not exist.

  ## Examples

      iex> get_url!(123)
      %Url{}

      iex> get_url!(456)
      ** (Ecto.NoResultsError)

  """
  def get_url!(id), do: Repo.get!(Url, id)

  @doc """
  Creates a url.

  ## Examples

      iex> create_url(%{field: value})
      {:ok, %Url{}}

      iex> create_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_url(attrs \\ %{}) do
    attrs = Map.put(attrs, "short_key", generate_short_key())

    %Url{}
    |> Url.changeset(attrs)
    |> Repo.insert()
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
