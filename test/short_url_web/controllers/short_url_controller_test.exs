defmodule ShortUrlWeb.ShortUrlControllerTest do
  use ShortUrlWeb.ConnCase, async: true

  test "GET /shorten_url returns a 404", %{conn: conn} do
    conn = get(conn, ~p"/shorten_url")
    assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
  end
end
