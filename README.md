# Timesheet

Flow decided:

*Employee:*
1. User logs in > Homepage shows user info
2. User click on `Sheets`
3. `Sheets` screen will show `timesheets` specific to user
4. User either creates a new sheet or selects and existing sheet
5. All available `jobs` will be visible to user
6. User then creates `Tasks` associated with the `sheet_id` and `job_id` [**NOT IMPLEMENTED**]



*Manager:* [**NOT IMPLEMENTED**]

1. User logins in > Homepage show user info
2. Homepage shows list of employees under manager
3. Homepage shows all timesheets pending approval
4. Homepage shows all timesheets over 8 hours

---

### Tables



List of tables

| Schema   |       Name        |   Type   |   Owner     |
| ------------- |:-------------:| -----:| -----:|
| public | contracts           | table    |  timesheet  |
| public | jobs                | table    |  timesheet  |
| public | roles               | table    |  timesheet  |
| public | sheets              | table    |  timesheet  |
| public | tasks               | table    |  timesheet  |
| public | users               | table    |  timesheet  |


Table `users`

| Column     |              Type                          |
| ---------------|-------------------------------------   |
| id            | bigint                                  |
| email         | character varying(255) (*unique*)       |
| name          | character varying(255)                  |
| role          | bigint (*foreign key* from roles table) |
| inserted_at   | timestamp(0) without time zone          |
| updated_at    | timestamp(0) without time zone          |
| password_hash | character varying(255)                  |


Table `tasks`

| Column      |              Type              |
| ----------- |:------------------------------:|
| id          | bigint                         |
| hours       | integer                        |
| sheet       | integer (*foreign key*)        |
| user_id     | bigint  (*foreign key*)        |
| job_code    | bigint  (*foreign key*)        |
| inserted_at | timestamp(0) without time zone |
| updated_at  | timestamp(0) without time zone |

Table `sheets`

| Column      |              Type              |
| ------------|--------------------------------|
| id          | bigint                         |
| total_hours | integer                        |
| user_id     | bigint    (*foreign key*)      |
| inserted_at | timestamp(0) without time zone |
| updated_at  | timestamp(0) without time zone |

Table `roles`

| Column      |              Type              |
| ------------|--------------------------------|
| id          | bigint                         |
| role_id     | integer   (*foreign key*)      |
| desc        | character varying(255)         |
| inserted_at | timestamp(0) without time zone |
| updated_at  | timestamp(0) without time zone |


Table `jobs`

| Column    |              Type                |
| ------------|--------------------------------|
| id          | bigint                         |
| job_code    | character varying(255)         |
| manager_id  | int  (*foreign key* from users)|
| inserted_at | timestamp(0) without time zone |
| updated_at  | timestamp(0) without time zone |

Table `contracts`

| Column      |              Type              |
| ------------|--------------------------------|
| id          | bigint                         |
| budget      | integer                        |
| manager_id  | int (*foreign key from users*) |
| inserted_at | timestamp(0) without time zone |
| updated_at  | timestamp(0) without time zone |


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
