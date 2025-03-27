defmodule ShortUrlWeb.Router do
  use ShortUrlWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug ShortUrlWeb.AllowedMethodsPlug, %{"shorten_url" => ["POST"]}
  end

  # Since the spec doesn't define the routes to go through /api I've
  # scoped the api routes to be directly accessed through the root.
  scope "/", ShortUrlWeb do
    pipe_through :api

    post "/shorten_url", ShortUrlController, :create
    get("/:short_key", ShortUrlController, :read)
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:short_url, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ShortUrlWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
