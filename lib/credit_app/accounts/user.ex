defmodule CreditApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :credit_points, :integer
    field :salary, :decimal
    field :approval_status, :boolean

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :credit_points, :salary, :approval_status])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end
end
