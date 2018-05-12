defmodule Beautify.BlindPrice do
  use Beautify.Web, :model

  schema "blind_prices" do
    field :price, :float
    field :matching_height, :integer
    field :matching_width, :integer

    belongs_to :blind_price_sheet, Beautify.BlindPriceSheet

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:price, :matching_height, :matching_width])
    |> validate_required([:price, :matching_height, :matching_width])
  end
end
