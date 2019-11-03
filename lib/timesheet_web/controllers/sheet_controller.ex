defmodule TimesheetWeb.SheetController do
  use TimesheetWeb, :controller

  alias Timesheet.Sheets
  alias Timesheet.Sheets.Sheet

  def index(conn, params) do
    #IO.inspect params
    current_user = TimesheetWeb.Plugs.FetchCurrentUser.call(conn, %{}).assigns.current_user
    sheets = Sheets.list_sheets_by_user_id( current_user.id )
    render(conn, "index.html", sheets: sheets)
  end

  def my_index(conn, params) do
    IO.inspect params
    sheets = Sheets.list_sheets_by_user_id( params )
    render(conn, "index.html", sheets: sheets)
  end

  def new(conn, _params) do
    changeset = Sheets.change_sheet(%Sheet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sheet" => sheet_params}) do
  current_user = TimesheetWeb.Plugs.FetchCurrentUser.call(conn, %{}).assigns.current_user
  sheet_params = Map.put sheet_params, "user_id", current_user.id
  IO.puts "==================="
  IO.inspect sheet_params
  IO.puts "==================="
    case Sheets.create_sheet(sheet_params) do
      {:ok, sheet} ->
        conn
        |> put_flash(:info, "Sheet created successfully.")
        |> redirect(to: Routes.sheet_path(conn, :show, sheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sheet = Sheets.get_sheet!(id)
    render(conn, "show.html", sheet: sheet)
  end

  def edit(conn, %{"id" => id}) do
    sheet = Sheets.get_sheet!(id)
    changeset = Sheets.change_sheet(sheet)
    render(conn, "edit.html", sheet: sheet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sheet" => sheet_params}) do
    sheet = Sheets.get_sheet!(id)

    case Sheets.update_sheet(sheet, sheet_params) do
      {:ok, sheet} ->
        conn
        |> put_flash(:info, "Sheet updated successfully.")
        |> redirect(to: Routes.sheet_path(conn, :show, sheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sheet: sheet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sheet = Sheets.get_sheet!(id)
    {:ok, _sheet} = Sheets.delete_sheet(sheet)

    conn
    |> put_flash(:info, "Sheet deleted successfully.")
    |> redirect(to: Routes.sheet_path(conn, :index))
  end
end
