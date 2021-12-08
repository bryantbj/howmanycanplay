defmodule HowmanycanplayWeb.PageController do
  use HowmanycanplayWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
