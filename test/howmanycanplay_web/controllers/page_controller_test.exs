defmodule HowmanycanplayWeb.PageControllerTest do
  use HowmanycanplayWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "How many can play"
  end
end
