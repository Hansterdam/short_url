defmodule ShortUrlWeb.ShortUrlController do
  use ShortUrlWeb, :controller

  def shorten(conn, params) do
    json(conn, %{"url" => params["url"], "short_url" => "http://localhost:4000/abc123"})
  end
end
