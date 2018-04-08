defmodule Beautify.ClientTest do
  use Beautify.ModelCase

  alias Beautify.Client

  @valid_attrs %{adress: "some content", name: "some content", surname: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Client.changeset(%Client{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Client.changeset(%Client{}, @invalid_attrs)
    refute changeset.valid?
  end
end
