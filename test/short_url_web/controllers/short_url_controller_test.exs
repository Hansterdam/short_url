defmodule ShortUrlWeb.ShortUrlControllerTest do
  use ShortUrlWeb.ConnCase, async: true

  test "GET /shorten_url returns a 405", %{conn: conn} do
    conn = get(conn, ~p"/shorten_url")
    assert json_response(conn, 405) == %{error: %{detail: "Method Not Allowed"}}
  end
end
