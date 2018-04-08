defmodule Beautify.Repo.Migrations.CreateAdress do
  use Ecto.Migration

  def change do
    create table(:adresses) do
      add :description, :string
      add :country, :string
      add :city, :string
      add :suburb, :string
      add :street_name, :string
      add :building_name, :string
      add :unit_number, :string
      add :postal_code, :string

      timestamps()
    end

  end
end
