defmodule ScrawledWeb.PageControllerTest do
  use ScrawledWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Michael Lee"
  end
end
