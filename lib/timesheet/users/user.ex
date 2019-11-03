defmodule Timesheet.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :role, :id
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    timestamps()
  end

  @doc false
  # email regex borrowed from: https://www.youtube.com/watch?v=D2W9gUvlaeU
  # Phoenix Framework 1.3 (Playing with Ecto Schemas and Phoenix Contexts)
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :role, :password, :password_confirmation])
    |> validate_confirmation( :password )
    |> validate_length(:password, min: 8) # too short
    |> hash_password()
    |> validate_required([:email, :name, :role, :password_hash])
    |> validate_format(:email, ~r/.+@.+\..+/, [message: "Please input a valid email"])
    |> unique_constraint(:email)
  end

#obtained from professor's notes
  def hash_password(cset) do
    pw = get_change(cset, :password)
    if pw do
      change(cset, Argon2.add_hash(pw))
    else
      cset
    end
  end

end
