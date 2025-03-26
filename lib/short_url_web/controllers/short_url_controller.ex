defmodule ShortUrlWeb.ShortUrlController do
  use ShortUrlWeb, :controller

  def shorten(conn, params) do
    IO.inspect(params, label: "controller params")

    case ShortUrl.ShortUrls.create_url(params) do
      {:ok, url} ->
        json(conn, %{
          "url" => url.url,
          "short_url" => "http://localhost:4000/" <> url.short_key
        })

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(ShortUrlWeb.ChangesetJSON)
        |> render(:error, changeset: changeset)
    end
  end
end
