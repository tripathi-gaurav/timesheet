defmodule Timesheet.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :hours, :integer
      add :sheet, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :job_code, references(:jobs, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:user_id])
    create index(:tasks, [:job_code])
  end
end
