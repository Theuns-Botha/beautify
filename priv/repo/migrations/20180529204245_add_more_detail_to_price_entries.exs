defmodule Beautify.Repo.Migrations.AddMoreDetailToPriceEntries do
  use Ecto.Migration

  def change do
    alter table(:blind_prices) do
      add :text_val, :string
      add :row_index, :integer
      add :column_index, :integer
      modify :price, :integer
    end
  end
end
