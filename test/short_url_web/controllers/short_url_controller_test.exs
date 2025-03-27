defmodule ShortUrlWeb.ShortUrlControllerTest do
  use ShortUrlWeb.ConnCase, async: true

  import ShortUrl.ShortUrlsFixtures

  test "GET /shorten_url returns a 404", %{conn: conn} do
    conn = get(conn, ~p"/shorten_url")
    assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
  end

  test "POST /shorten_url with non-link gives a validation error", %{conn: conn} do
    conn = post(conn, ~p"/shorten_url", %{"url" => "actually not a url"})

    assert json_response(conn, 422) == %{
             "errors" => %{"url" => ["has invalid format"]}
           }
  end

  test "GET /:short_key should return 404 for non-existent url", %{conn: conn} do
    conn = get(conn, ~p"/doesnt-exist")

    assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
  end

  test "GET /:short_key should redirect", %{conn: conn} do
    url = url_fixture()
    conn = get(conn, ~p"/#{url.short_key}")

    assert response(conn, 302)
  end
end
