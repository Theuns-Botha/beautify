defmodule :"Elixir.Beautify.Repo.Migrations.Change-client-adress-to-list" do
  use Ecto.Migration

  def change do
    alter table(:clients) do
      remove :adress
    end

    alter table(:adresses) do
      add :client_id, references(:clients, on_delete: :delete_all)
      add :supplier_id, references(:suppliers, on_delete: :delete_all)
    end

    create index(:adresses, [:client_id])
    create index(:adresses, [:supplier_id])
  end
end
