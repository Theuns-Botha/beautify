defmodule Beautify.Client do
  use Beautify.Web, :model

  schema "clients" do
    field :name, :string
    field :surname, :string
    field :adress, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :surname, :adress])
    |> validate_required([:name, :surname, :adress])
  end
end
