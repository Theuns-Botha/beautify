defmodule Beautify.Repo.Migrations.CreateClient do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :name, :string
      add :surname, :string
      add :adress, :string

      timestamps()
    end

  end
end
