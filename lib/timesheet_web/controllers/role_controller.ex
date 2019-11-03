defmodule TimesheetWeb.RoleController do
  use TimesheetWeb, :controller

  alias Timesheet.Roles
  alias Timesheet.Roles.Role

  def index(conn, _params) do
    roles = Roles.list_roles()
    render(conn, "index.html", roles: roles)
  end

  def new(conn, _params) do
    changeset = Roles.change_role(%Role{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"role" => role_params}) do
    case Roles.create_role(role_params) do
      {:ok, role} ->
        conn
        |> put_flash(:info, "Role created successfully.")
        |> redirect(to: Routes.role_path(conn, :show, role))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    role = Roles.get_role!(id)
    render(conn, "show.html", role: role)
  end

  def edit(conn, %{"id" => id}) do
    role = Roles.get_role!(id)
    changeset = Roles.change_role(role)
    render(conn, "edit.html", role: role, changeset: changeset)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Roles.get_role!(id)

    case Roles.update_role(role, role_params) do
      {:ok, role} ->
        conn
        |> put_flash(:info, "Role updated successfully.")
        |> redirect(to: Routes.role_path(conn, :show, role))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", role: role, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Roles.get_role!(id)
    {:ok, _role} = Roles.delete_role(role)

    conn
    |> put_flash(:info, "Role deleted successfully.")
    |> redirect(to: Routes.role_path(conn, :index))
  end
end
