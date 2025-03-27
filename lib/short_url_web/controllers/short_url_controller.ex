defmodule ShortUrlWeb.ShortUrlController do
  alias ShortUrl.ShortUrls.Url
  use ShortUrlWeb, :controller

  def create(conn, params) do
    case ShortUrl.ShortUrls.create_url(params) do
      {:ok, url} ->
        json(conn, %{
          "url" => url.url,
          "short_url" => "http://localhost/" <> url.short_key
        })

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(ShortUrlWeb.ChangesetJSON)
        |> render(:error, changeset: changeset)
    end
  end

  def read(conn, params) do
    case ShortUrl.ShortUrls.get_url_by_short_key(params["short_key"]) do
      %Url{} = url ->
        redirect(conn, external: url.url)

      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(ShortUrlWeb.ErrorJSON)
        |> render("404.json")
    end
  end
end
