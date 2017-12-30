defmodule AtefBotWeb.PageController do
  use AtefBotWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
