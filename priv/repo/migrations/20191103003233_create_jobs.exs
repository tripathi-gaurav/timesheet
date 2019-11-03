defmodule Timesheet.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :job_code, :string
      add :manager_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:jobs, [:manager_id])
  end
end
