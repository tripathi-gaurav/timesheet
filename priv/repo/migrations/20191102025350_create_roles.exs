defmodule Timesheet.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    drop_if_exists table(:roles)

    create table(:roles) do
      add :role_id, :integer
      add :desc, :string

      timestamps()
    end

  end
end
