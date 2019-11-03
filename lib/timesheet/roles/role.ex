defmodule Timesheet.Roles.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :desc, :string
    field :role_id, :integer

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:role_id, :desc])
    |> validate_required([:role_id, :desc])
    |> unique_constraint(:role_id)
  end
end
