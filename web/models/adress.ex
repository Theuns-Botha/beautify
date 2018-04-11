defmodule Beautify.Adress do
  use Beautify.Web, :model

  schema "adresses" do
    field :description, :string
    field :country, :string
    field :city, :string
    field :suburb, :string
    field :street_name, :string
    field :building_name, :string
    field :unit_number, :string
    field :postal_code, :string

    belongs_to :client, Beautify.Client
    belongs_to :supplier, Beautify.Supplier

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :country, :city, :suburb, :street_name, :building_name, :unit_number, :postal_code])
    |> validate_required([:description, :country, :city, :suburb, :street_name, :building_name, :unit_number, :postal_code])
  end
end
