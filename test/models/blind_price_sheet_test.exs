defmodule Beautify.BlindPriceSheetTest do
  use Beautify.ModelCase

  alias Beautify.BlindPriceSheet

  @valid_attrs %{descriptin: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BlindPriceSheet.changeset(%BlindPriceSheet{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BlindPriceSheet.changeset(%BlindPriceSheet{}, @invalid_attrs)
    refute changeset.valid?
  end
end
