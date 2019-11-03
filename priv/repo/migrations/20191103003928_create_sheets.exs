defmodule Timesheet.Repo.Migrations.CreateSheets do
  use Ecto.Migration

  def change do
    create table(:sheets) do
      add :total_hours, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:sheets, [:user_id])
  end
end
