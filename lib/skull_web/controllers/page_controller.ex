defmodule SkullWeb.PageController do
  use SkullWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
