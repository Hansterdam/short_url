defmodule ShortUrl.ShortUrlsTest do
  use ShortUrl.DataCase

  alias ShortUrl.ShortUrls

  describe "urls" do
    alias ShortUrl.ShortUrls.Url

    import ShortUrl.ShortUrlsFixtures

    @invalid_attrs %{"url" => "not a url"}

    test "get_url_by_short_key/1 returns the url with given short key" do
      url = url_fixture()
      assert ShortUrls.get_url_by_short_key(url.short_key) == url
    end

    test "create_url/1 with valid data creates a url" do
      :rand.seed(:exsss, {100, 101, 102})
      valid_attrs = %{"url" => "https://very-long-url.com"}

      assert {:ok, %Url{} = url} = ShortUrls.create_url(valid_attrs)
      assert url.url == "https://very-long-url.com"
      assert url.short_key == "g3cmz5"
    end

    test "create_url/1 with http:// also works" do
      valid_attrs = %{"url" => "http://not-secure_url.com"}

      assert {:ok, %Url{}} = ShortUrls.create_url(valid_attrs)
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ShortUrls.create_url(@invalid_attrs)
    end

    test "create_url/1 with existing url, returns existing record" do
      existing_url = url_fixture()
      url_response = ShortUrls.create_url(%{"url" => existing_url.url})
      assert {:ok, existing_url} == url_response
    end
  end
end
