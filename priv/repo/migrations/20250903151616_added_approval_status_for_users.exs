defmodule CreditApp.Repo.Migrations.AddedApprovalStatusForUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :approval_status, :boolean
    end
  end
end
