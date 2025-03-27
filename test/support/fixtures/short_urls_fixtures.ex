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
        "url" => "https://some-url.com"
      })
      |> ShortUrl.ShortUrls.create_url()

    url
  end
end
