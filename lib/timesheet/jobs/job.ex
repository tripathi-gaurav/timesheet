defmodule Timesheet.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :job_code, :string
    field :manager_id, :id

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:job_code])
    |> validate_required([:job_code])
  end
end
