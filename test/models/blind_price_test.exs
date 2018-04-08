defmodule Beautify.BlindPriceTest do
  use Beautify.ModelCase

  alias Beautify.BlindPrice

  @valid_attrs %{matching_height: 42, matching_width: 42, price: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BlindPrice.changeset(%BlindPrice{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BlindPrice.changeset(%BlindPrice{}, @invalid_attrs)
    refute changeset.valid?
  end
end
