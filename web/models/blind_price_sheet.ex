defmodule Beautify.BlindPriceSheet do
  use Beautify.Web, :model

  schema "blind_price_sheets" do
    field :descriptin, :string

    has_many :blind_prices, Beautify.BlindPrice

    belongs_to :supplier, Beautify.Supplier

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:descriptin])
    |> cast_assoc(:blind_prices)
    |> validate_required([:descriptin])
  end
end
