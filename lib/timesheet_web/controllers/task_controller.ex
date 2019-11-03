defmodule TimesheetWeb.TaskController do
  use TimesheetWeb, :controller

  alias Timesheet.Tasks
  alias Timesheet.Tasks.Task

  def index(conn, %{"id" => id}) do
    tasks = Tasks.get_task_by_job_id!(id)
    render(conn, "index.html", tasks: tasks)
  end

  def index(conn, %{"job" => job, "sheet" => sheet}) do
    IO.puts "***************"
    IO.inspect job
    IO.inspect sheet
    IO.puts "***************"
    current_user = TimesheetWeb.Plugs.FetchCurrentUser.call(conn, %{}).assigns.current_user
    tasks = Tasks.get_task_by_sheet_id_user_id_and_job_code!( sheet, current_user.id, job)
    render(conn, "show.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  #def create(conn, %{"task" => task_params}) do
  def create(conn, %{"job" => job, "sheet" => sheet}) do
    IO.puts "***************"
    IO.inspect job
    IO.inspect sheet
    IO.puts "***************"
    current_user = TimesheetWeb.Plugs.FetchCurrentUser.call(conn, %{}).assigns.current_user
    tasks = Tasks.get_task_by_sheet_id_user_id_and_job_code!( sheet.id, current_user.id, job.id)
    render(conn, "show.html", tasks: tasks)
    # task_params = Map.put(task_params, "user_id", conn.assigns[:current_user].id)
    
    # case Tasks.create_task(task_params) do
    #   {:ok, task} ->
    #     conn
    #     |> put_flash(:info, "Task created successfully.")
    #     |> redirect(to: Routes.task_path(conn, :show, task))

    #   {:error, %Ecto.Changeset{} = changeset} ->
    #     render(conn, "new.html", changeset: changeset)
    # end
  end

  def show(conn, job, sheet) do
    IO.inspect job
    IO.inspect sheet
    current_user = TimesheetWeb.Plugs.FetchCurrentUser.call(conn, %{}).assigns.current_user
    tasks = Tasks.get_task_by_sheet_id_user_id_and_job_code!( sheet.id, current_user.id, job.id)
    render(conn, "show.html", tasks: tasks)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
