defmodule CreditApp.Models.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias CreditApp.Models.Validators.Regex, as: RegexValidator

  schema "users" do
    field :name, :string
    field :email, :string
    field :credit_points, :integer
    field :approval_status, :boolean
    has_many :salary_records, CreditApp.Models.SalaryRecord

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :name,
      :email,
      :credit_points,
      :approval_status
    ])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
    |> validate_format(:name, RegexValidator.name_regex(),
      message: "Name must contain only letters and spaces"
    )
    |> validate_format(:email, RegexValidator.email_regex(), message: "Invalid email format")
  end
end
