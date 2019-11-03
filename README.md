# Timesheet

Flow decided:
1. User logs in > Homepage shows user info
2. User click on `Sheets`
3. `Sheets` screen will show `timesheets` specific to user
4. User either creates a new sheet or selects and existing sheet
5. All available `jobs` will be visible to user
6. User then creates `Tasks` associated with the `sheet_id` and `job_id` [**NOT IMPLEMENTED**]

### Tables
List of tables
| Schema   |       Name        |   Type   |   Owner     |
| -------- +------------------ + -------- + ------------|
| public | contracts           | table    |  timesheet  |
| public | jobs                | table    |  timesheet  |
| public | roles               | table    |  timesheet  |
| public | sheets              | table    |  timesheet  |
| public | tasks               | table    |  timesheet  |
| public | users               | table    |  timesheet  |


Table "public.users"
Column     |              Type              | Collation | Nullable |              Default              | Storage  | Stats target | Description
---------------+--------------------------------+-----------+----------+-----------------------------------+----------+--------------+-------------
id            | bigint                         |           | not null | nextval('users_id_seq'::regclass) | plain    |              |
email         | character varying(255)         |           |          |                                   | extended |              |
name          | character varying(255)         |           |          |                                   | extended |              | 
role          | bigint                         |           | not null | 1                                 | plain    |              |
inserted_at   | timestamp(0) without time zone |           | not null |                                   | plain    |              |
updated_at    | timestamp(0) without time zone |           | not null |                                   | plain    |              |
password_hash | character varying(255)         |           | not null | ''::character varying             | extended |              |


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
