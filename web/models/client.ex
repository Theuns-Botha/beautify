defmodule Beautify.Client do
  use Beautify.Web, :model

  schema "clients" do
    field :name, :string
    field :surname, :string

    has_many :adresses, Beautify.Adress

    has_one :primary_adress, Beautify.Adress

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :surname])
    |> validate_required([:name, :surname])
  end
end
