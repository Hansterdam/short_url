defmodule ShortUrl.ShortUrlsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ShortUrl.ShortUrls` context.
  """

  @doc """
  Generate a url.
  """
  def url_fixture(attrs \\ %{}) do
    {:ok, url} =
      attrs
      |> Enum.into(%{
        url: "some url",
        short_key: "some short_key"
      })
      |> ShortUrl.ShortUrls.create_url()

    url
  end
end
