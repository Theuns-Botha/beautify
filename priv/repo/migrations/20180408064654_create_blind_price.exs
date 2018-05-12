defmodule Beautify.Repo.Migrations.CreateBlindPrice do
  use Ecto.Migration

  def change do
    create table(:blind_prices) do
      add :price, :float
      add :matching_height, :integer
      add :matching_width, :integer

      timestamps()
    end

  end
end
