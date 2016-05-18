defmodule Speck.PageController do
  use Speck.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
