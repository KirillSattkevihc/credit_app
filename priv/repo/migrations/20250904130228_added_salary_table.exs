defmodule CreditApp.Repo.Migrations.AddedSalaryTable do
  use Ecto.Migration

  def change do
    create table(:salary_records) do
      add :income, :decimal
      add :expenses, :decimal
      add :credit_limit, :decimal
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:salary_records, [:user_id])
  end
end
