defmodule Beautify.Supplier do
  use Beautify.Web, :model

  schema "suppliers" do
    field :name, :string
    field :description, :string

    has_many :adresses, Beautify.Adress
    has_many :blind_price_sheets, Beautify.BlindPriceSheet

    has_one :primary_adress, Beautify.Adress

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name, :description])
  end
end
