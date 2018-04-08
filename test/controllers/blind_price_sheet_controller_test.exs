defmodule Beautify.BlindPriceSheetControllerTest do
  use Beautify.ConnCase

  alias Beautify.BlindPriceSheet
  @valid_attrs %{descriptin: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, blind_price_sheet_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing blind price sheets"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, blind_price_sheet_path(conn, :new)
    assert html_response(conn, 200) =~ "New blind price sheet"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, blind_price_sheet_path(conn, :create), blind_price_sheet: @valid_attrs
    assert redirected_to(conn) == blind_price_sheet_path(conn, :index)
    assert Repo.get_by(BlindPriceSheet, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, blind_price_sheet_path(conn, :create), blind_price_sheet: @invalid_attrs
    assert html_response(conn, 200) =~ "New blind price sheet"
  end

  test "shows chosen resource", %{conn: conn} do
    blind_price_sheet = Repo.insert! %BlindPriceSheet{}
    conn = get conn, blind_price_sheet_path(conn, :show, blind_price_sheet)
    assert html_response(conn, 200) =~ "Show blind price sheet"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, blind_price_sheet_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    blind_price_sheet = Repo.insert! %BlindPriceSheet{}
    conn = get conn, blind_price_sheet_path(conn, :edit, blind_price_sheet)
    assert html_response(conn, 200) =~ "Edit blind price sheet"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    blind_price_sheet = Repo.insert! %BlindPriceSheet{}
    conn = put conn, blind_price_sheet_path(conn, :update, blind_price_sheet), blind_price_sheet: @valid_attrs
    assert redirected_to(conn) == blind_price_sheet_path(conn, :show, blind_price_sheet)
    assert Repo.get_by(BlindPriceSheet, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    blind_price_sheet = Repo.insert! %BlindPriceSheet{}
    conn = put conn, blind_price_sheet_path(conn, :update, blind_price_sheet), blind_price_sheet: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit blind price sheet"
  end

  test "deletes chosen resource", %{conn: conn} do
    blind_price_sheet = Repo.insert! %BlindPriceSheet{}
    conn = delete conn, blind_price_sheet_path(conn, :delete, blind_price_sheet)
    assert redirected_to(conn) == blind_price_sheet_path(conn, :index)
    refute Repo.get(BlindPriceSheet, blind_price_sheet.id)
  end
end
