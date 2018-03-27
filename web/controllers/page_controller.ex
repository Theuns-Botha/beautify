defmodule Beautify.PageController do
  use Beautify.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
