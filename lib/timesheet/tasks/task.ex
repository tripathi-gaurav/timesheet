defmodule Timesheet.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :hours, :integer
    field :sheet, :integer
    field :user_id, :id
    field :job_code, :id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:hours, :sheet])
    |> validate_required([:hours, :sheet, :user_id])
  end
end
