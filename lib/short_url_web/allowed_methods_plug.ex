defmodule ShortUrlWeb.AllowedMethodsPlug do
  import Plug.Conn
  import Phoenix.Controller

  # I've added this plug because I wasn't happy with the out-of-the-box
  # handling of not allowed methods (just a 404), so I wanted that to be
  # properly communicated through the api
  def init(opts) do
    opts
  end

  def call(conn, path_methods) do
    case path_methods[hd(conn.path_info)] do
      # Path not in our config, let it pass through
      nil ->
        conn

      allowed_methods ->
        if Enum.member?(allowed_methods, conn.method) do
          # Method is allowed for this path
          conn
        else
          # Method not allowed
          conn
          |> put_status(:method_not_allowed)
          |> put_resp_header("allow", Enum.join(allowed_methods, ", "))
          |> put_view(ShortUrlWeb.ErrorJSON)
          |> render("405.json")
          |> halt()
        end
    end
  end
end
