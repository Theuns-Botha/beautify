defmodule Beautify.Repo.Migrations.CreateBlindPriceSheet do
  use Ecto.Migration

  def change do
    create table(:blind_price_sheets) do
      add :descriptin, :string

      timestamps()
    end

  end
end
