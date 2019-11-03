defmodule TimesheetWeb.JobController do
  use TimesheetWeb, :controller

  alias Timesheet.Jobs
  alias Timesheet.Jobs.Job
  alias Timesheet.Sheets
  alias Timesheet.Sheets.Sheet

  def index(conn, sheet) do
    # jobs = Jobs.list_jobs()
    # render(conn, "index.html", jobs: jobs)
    IO.inspect sheet
    current_user = TimesheetWeb.Plugs.FetchCurrentUser.call(conn, %{}).assigns.current_user
    jobs = Jobs.list_jobs()
    render(conn, "index.html", jobs: jobs, sheet: sheet)
  end

  def my_index(conn, sheet) do
    IO.inspect sheet
    current_user = TimesheetWeb.Plugs.FetchCurrentUser.call(conn, %{}).assigns.current_user
    tasks = Tasks.list_jobs( )
    render(conn, "index.html", tasks: tasks, sheet: sheet)
  end

  def new(conn, _params) do
    changeset = Jobs.change_job(%Job{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"job" => job_params}) do
    case Jobs.create_job(job_params) do
      {:ok, job} ->
        conn
        |> put_flash(:info, "Job created successfully.")
        |> redirect(to: Routes.job_path(conn, :show, job))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, params) do
    #job = Jobs.get_job!(id)
    #render(conn, "show.html", job: job)

    IO.inspect params
    current_user = TimesheetWeb.Plugs.FetchCurrentUser.call(conn, %{}).assigns.current_user
    #tasks = Tasks.list_tasks_by_user_id_and_sheet_id( current_user.id, params["id"] )
    sheet = Sheets.get_sheet_by_id params["id"]
    IO.inspect sheet
    jobs = Jobs.list_jobs()
    params_to_pass = %{ sheet: sheet, jobs: jobs }
    render(conn, "index.html", sheet: sheet, jobs: jobs)

  end

  def edit(conn, %{"id" => id}) do
    job = Jobs.get_job!(id)
    changeset = Jobs.change_job(job)
    render(conn, "edit.html", job: job, changeset: changeset)
  end

  def update(conn, %{"id" => id, "job" => job_params}) do
    job = Jobs.get_job!(id)

    case Jobs.update_job(job, job_params) do
      {:ok, job} ->
        conn
        |> put_flash(:info, "Job updated successfully.")
        |> redirect(to: Routes.job_path(conn, :show, job))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", job: job, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    job = Jobs.get_job!(id)
    {:ok, _job} = Jobs.delete_job(job)

    conn
    |> put_flash(:info, "Job deleted successfully.")
    |> redirect(to: Routes.job_path(conn, :index))
  end
end
