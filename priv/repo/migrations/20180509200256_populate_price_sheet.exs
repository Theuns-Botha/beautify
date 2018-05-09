defmodule Beautify.Repo.Migrations.PopulatePriceSheet do
  use Ecto.Migration

  def change do
    alter table(:blind_price_sheets) do
      add :supplier_id, references(:suppliers, on_delete: :delete_all)
    end

    alter table(:blind_prices) do
      add :blind_price_sheet_id, references(:blind_price_sheets, on_delete: :delete_all)
    end

    create index(:blind_price_sheets, [:supplier_id])
    create index(:blind_prices, [:blind_price_sheet_id])

  end
end
