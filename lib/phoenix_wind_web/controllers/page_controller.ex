defmodule PhoenixWindWeb.PageController do
  use PhoenixWindWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
