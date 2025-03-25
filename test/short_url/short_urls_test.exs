defmodule ShortUrl.ShortUrlsTest do
  use ShortUrl.DataCase

  alias ShortUrl.ShortUrls

  describe "urls" do
    alias ShortUrl.ShortUrls.Url

    import ShortUrl.ShortUrlsFixtures

    @invalid_attrs %{original_url: nil, short_key: nil}

    test "list_urls/0 returns all urls" do
      url = url_fixture()
      assert ShortUrls.list_urls() == [url]
    end

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert ShortUrls.get_url!(url.id) == url
    end

    test "create_url/1 with valid data creates a url" do
      valid_attrs = %{original_url: "some original_url", short_key: "some short_key"}

      assert {:ok, %Url{} = url} = ShortUrls.create_url(valid_attrs)
      assert url.original_url == "some original_url"
      assert url.short_key == "some short_key"
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ShortUrls.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = url_fixture()
      update_attrs = %{original_url: "some updated original_url", short_key: "some updated short_key"}

      assert {:ok, %Url{} = url} = ShortUrls.update_url(url, update_attrs)
      assert url.original_url == "some updated original_url"
      assert url.short_key == "some updated short_key"
    end

    test "update_url/2 with invalid data returns error changeset" do
      url = url_fixture()
      assert {:error, %Ecto.Changeset{}} = ShortUrls.update_url(url, @invalid_attrs)
      assert url == ShortUrls.get_url!(url.id)
    end

    test "delete_url/1 deletes the url" do
      url = url_fixture()
      assert {:ok, %Url{}} = ShortUrls.delete_url(url)
      assert_raise Ecto.NoResultsError, fn -> ShortUrls.get_url!(url.id) end
    end

    test "change_url/1 returns a url changeset" do
      url = url_fixture()
      assert %Ecto.Changeset{} = ShortUrls.change_url(url)
    end
  end
end
