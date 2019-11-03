defmodule Timesheet.Sheets.Sheet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sheets" do
    field :total_hours, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(sheet, attrs) do
    sheet
    |> cast(attrs, [:total_hours, :user_id])
    |> validate_required([:total_hours, :user_id])
  end
end
