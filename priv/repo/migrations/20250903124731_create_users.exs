defmodule CreditApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :credit_points, :integer, default: 0

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])
  end
end
