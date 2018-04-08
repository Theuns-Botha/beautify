defmodule Beautify.BlindPriceSheet do
  use Beautify.Web, :model

  schema "blind_price_sheets" do
    field :descriptin, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:descriptin])
    |> validate_required([:descriptin])
  end
end
