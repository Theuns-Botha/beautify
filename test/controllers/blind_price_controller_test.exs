defmodule Beautify.BlindPriceControllerTest do
  use Beautify.ConnCase

  alias Beautify.BlindPrice
  @valid_attrs %{matching_height: 42, matching_width: 42, price: "120.5"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, blind_price_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing blind prices"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, blind_price_path(conn, :new)
    assert html_response(conn, 200) =~ "New blind price"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, blind_price_path(conn, :create), blind_price: @valid_attrs
    assert redirected_to(conn) == blind_price_path(conn, :index)
    assert Repo.get_by(BlindPrice, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, blind_price_path(conn, :create), blind_price: @invalid_attrs
    assert html_response(conn, 200) =~ "New blind price"
  end

  test "shows chosen resource", %{conn: conn} do
    blind_price = Repo.insert! %BlindPrice{}
    conn = get conn, blind_price_path(conn, :show, blind_price)
    assert html_response(conn, 200) =~ "Show blind price"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, blind_price_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    blind_price = Repo.insert! %BlindPrice{}
    conn = get conn, blind_price_path(conn, :edit, blind_price)
    assert html_response(conn, 200) =~ "Edit blind price"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    blind_price = Repo.insert! %BlindPrice{}
    conn = put conn, blind_price_path(conn, :update, blind_price), blind_price: @valid_attrs
    assert redirected_to(conn) == blind_price_path(conn, :show, blind_price)
    assert Repo.get_by(BlindPrice, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    blind_price = Repo.insert! %BlindPrice{}
    conn = put conn, blind_price_path(conn, :update, blind_price), blind_price: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit blind price"
  end

  test "deletes chosen resource", %{conn: conn} do
    blind_price = Repo.insert! %BlindPrice{}
    conn = delete conn, blind_price_path(conn, :delete, blind_price)
    assert redirected_to(conn) == blind_price_path(conn, :index)
    refute Repo.get(BlindPrice, blind_price.id)
  end
end
