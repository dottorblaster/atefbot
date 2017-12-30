defmodule AtefBotWeb.Router do
  use AtefBotWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AtefBotWeb do
    pipe_through :api # Use the default browser stack

    get "/", BotController, :index
    get "/webhook", BotController, :challenge
    post "/webhook", BotController, :message
  end

  # Other scopes may use custom stacks.
  # scope "/api", AtefBotWeb do
  #   pipe_through :api
  # end
end
