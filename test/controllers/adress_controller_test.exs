defmodule Beautify.AdressControllerTest do
  use Beautify.ConnCase

  alias Beautify.Adress
  @valid_attrs %{building_name: "some content", city: "some content", country: "some content", description: "some content", postal_code: "some content", street_name: "some content", suburb: "some content", unit_number: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, adress_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing adresses"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, adress_path(conn, :new)
    assert html_response(conn, 200) =~ "New adress"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, adress_path(conn, :create), adress: @valid_attrs
    assert redirected_to(conn) == adress_path(conn, :index)
    assert Repo.get_by(Adress, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, adress_path(conn, :create), adress: @invalid_attrs
    assert html_response(conn, 200) =~ "New adress"
  end

  test "shows chosen resource", %{conn: conn} do
    adress = Repo.insert! %Adress{}
    conn = get conn, adress_path(conn, :show, adress)
    assert html_response(conn, 200) =~ "Show adress"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, adress_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    adress = Repo.insert! %Adress{}
    conn = get conn, adress_path(conn, :edit, adress)
    assert html_response(conn, 200) =~ "Edit adress"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    adress = Repo.insert! %Adress{}
    conn = put conn, adress_path(conn, :update, adress), adress: @valid_attrs
    assert redirected_to(conn) == adress_path(conn, :show, adress)
    assert Repo.get_by(Adress, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    adress = Repo.insert! %Adress{}
    conn = put conn, adress_path(conn, :update, adress), adress: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit adress"
  end

  test "deletes chosen resource", %{conn: conn} do
    adress = Repo.insert! %Adress{}
    conn = delete conn, adress_path(conn, :delete, adress)
    assert redirected_to(conn) == adress_path(conn, :index)
    refute Repo.get(Adress, adress.id)
  end
end
