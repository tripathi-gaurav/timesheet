# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Timesheet.Repo.insert!(%Timesheet.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
import Ecto.Query
alias Timesheet.Repo
alias Timesheet.Users.User
alias Timesheet.Roles.Role
alias Timesheet.Sheets.Sheet
alias Timesheet.Jobs.Job
alias Timesheet.Tasks.Task


Repo.delete_all(User)
Repo.delete_all(Role)
IO.puts "Delted.."
#flush()
Repo.insert!(%Role{role_id: 1, desc: "employee"})
Repo.insert!(%Role{role_id: 2, desc: "manager"})
IO.puts "roles inserted"

employee = Repo.get_by(Role, role_id: 1)
manager = Repo.get_by(Role, role_id: 2)
# IO.inspect employee
# IO.puts employee.id
# IO.puts employee.role_id

Repo.insert!(%User{name: "Naezy", email: "naezy@gullygang.com", role: employee.id} )
Repo.insert!(%User{name: "Divine", email: "divine@gullygang.com", role: manager.id} )
#Repo.insert!(%User{name: "Gandalf", email: "gandalf@middleearth.com"}, role_id: 2)

IO.puts "inserting jobs"

job = Repo.insert!(%Job{job_code: "AX589", manager_id: manager.id} )


Repo.insert!( %Sheet{ total_hours: 4, user_id: employee.id } )

sheet = Repo.get_by( Sheet, user_id: employee.id )

Repo.insert!( %Task{ hours: 4, sheet: sheet.id, user_id: employee.id, job_code: job.id} )