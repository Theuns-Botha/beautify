defmodule Beautify.AdressTest do
  use Beautify.ModelCase

  alias Beautify.Adress

  @valid_attrs %{building_name: "some content", city: "some content", country: "some content", description: "some content", postal_code: "some content", street_name: "some content", suburb: "some content", unit_number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Adress.changeset(%Adress{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Adress.changeset(%Adress{}, @invalid_attrs)
    refute changeset.valid?
  end
end
