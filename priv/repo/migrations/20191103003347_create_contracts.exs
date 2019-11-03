defmodule Timesheet.Repo.Migrations.CreateContracts do
  use Ecto.Migration

  def change do
    create table(:contracts) do
      add :budget, :integer
      add :manager_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:contracts, [:manager_id])
  end
end
