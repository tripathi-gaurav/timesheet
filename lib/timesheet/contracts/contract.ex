defmodule Timesheet.Contracts.Contract do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contracts" do
    field :budget, :integer
    field :manager_id, :id

    timestamps()
  end

  @doc false
  def changeset(contract, attrs) do
    contract
    |> cast(attrs, [:budget])
    |> validate_required([:budget])
  end
end
