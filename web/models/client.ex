defmodule Beautify.Client do
  use Beautify.Web, :model

  schema "clients" do
    field :name, :string
    field :surname, :string

    has_many :adresses, Beautify.Adress

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :surname])
    |> validate_required([:name, :surname])
    |> cast_assoc(:adresses, required: false)
  end

  #This changeset is only to be used to get a client_id when "new" client is being created
  def unvalidated_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :surname])
  end

end
