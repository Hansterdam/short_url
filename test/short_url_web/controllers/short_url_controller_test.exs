defmodule ShortUrlWeb.ShortUrlControllerTest do
  use ShortUrlWeb.ConnCase, async: false

  test "GET /shorten_url returns a 404", %{conn: conn} do
    conn = get(conn, ~p"/shorten_url")
    assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
  end

  test "POST /shorten_url returns a shortened url", %{conn: conn} do
    :rand.seed(:exsss, {100, 101, 102})
    conn = post(conn, ~p"/shorten_url", %{"url" => "http://very-long-url.com"})

    assert json_response(conn, 200) == %{
             "url" => "http://very-long-url.com",
             "short_url" => "http://localhost:4000/g3cmz5"
           }
  end

  # test "POST /shorten_url with non-link gives a validation error", %{conn: conn} do
  #   conn = post(conn, ~p"/shorten_url", %{"url" => "actually not a url"})

  #   assert json_response(conn, 422) == %{
  #            "errors" => %{"url" => ["has invalid format"]}
  #          }
  # end
end
