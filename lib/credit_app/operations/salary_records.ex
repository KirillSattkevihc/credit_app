defmodule CreditApp.Operations.SalaryRecords do
  @moduledoc """
  Operations for managing SalaryRecord entries.
  """

  require Ecto.Query

  alias CreditApp.Repo
  alias CreditApp.Models.SalaryRecord

  @type salary_attrs :: %{
          required(:user_id) => binary(),
          required(:income) => Decimal.t() | String.t(),
          required(:expenses) => Decimal.t() | String.t(),
          required(:credit_limit) => Decimal.t()
        }

  @spec create(salary_attrs()) :: {:ok, SalaryRecord.t()} | {:error, Ecto.Changeset.t()}
  def create(attrs) do
    %SalaryRecord{}
    |> SalaryRecord.changeset(attrs)
    |> Repo.insert()
  end

  @spec get(binary()) :: SalaryRecord.t() | nil
  def get(id) do
    Repo.get(SalaryRecord, id)
  end

  @spec get!(binary()) :: SalaryRecord.t()
  def get!(id) do
    Repo.get!(SalaryRecord, id)
  end

  @spec update(SalaryRecord.t(), map()) :: {:ok, SalaryRecord.t()} | {:error, Ecto.Changeset.t()}
  def update(%SalaryRecord{} = record, attrs) do
    record
    |> SalaryRecord.changeset(attrs)
    |> Repo.update()
  end
end
