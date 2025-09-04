defmodule CreditApp.Models.SalaryRecord do
  use Ecto.Schema
  import Ecto.Changeset

  alias CreditApp.Models.User

  schema "salary_records" do
    field :income, :decimal
    field :expenses, :decimal
    field :credit_limit, :decimal
    belongs_to :user, User

    timestamps()
  end

  def changeset(record, attrs) do
    record
    |> cast(attrs, [:income, :expenses, :credit_limit, :user_id])
    |> validate_required([:income, :expenses, :credit_limit, :user_id])
  end
end
