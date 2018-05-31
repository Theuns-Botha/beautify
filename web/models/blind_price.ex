defmodule Beautify.BlindPrice do
  use Beautify.Web, :model

  schema "blind_prices" do
    field :price, :integer
    field :text_val, :string
    field :matching_height, :integer
    field :matching_width, :integer
    field :row_index, :integer
    field :column_index, :integer

    belongs_to :blind_price_sheet, Beautify.BlindPriceSheet

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:price, :text_val, :matching_height, :matching_width, :row_index, :column_index])
    |> validate_required([:row_index, :column_index])
  end

end
