defmodule Beautify.SupplierTest do
  use Beautify.ModelCase

  alias Beautify.Supplier

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Supplier.changeset(%Supplier{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Supplier.changeset(%Supplier{}, @invalid_attrs)
    refute changeset.valid?
  end
end
