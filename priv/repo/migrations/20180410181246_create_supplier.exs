defmodule Beautify.Repo.Migrations.CreateSupplier do
  use Ecto.Migration

  def change do
    create table(:suppliers) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
