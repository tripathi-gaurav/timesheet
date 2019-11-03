defmodule Timesheet.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
   drop_if_exists table(:users)
   drop_if_exists table(:roles)
    
    create table(:roles) do
      add :role_id, :integer
      add :desc, :string

      timestamps()
    end
    
    create table(:users) do
      add :email, :string
      add :name, :string
      add :role, references("roles"), null: false, default: 1

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
