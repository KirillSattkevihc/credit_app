defmodule CreditApp.Operations.SalaryRecordsTest do
  use CreditApp.DataCase, async: true

  alias CreditApp.Operations.SalaryRecords
  alias CreditApp.Models.SalaryRecord
  alias CreditApp.Factory

  describe "create/1" do
    test "creates a salary record with valid attributes" do
      user = Factory.insert(:user)

      attrs = %{
        user_id: user.id,
        income: "5000",
        expenses: "2000",
        credit_limit: "36000"
      }

      assert {:ok, %SalaryRecord{} = record} = SalaryRecords.create(attrs)
      assert record.user_id == user.id
      assert Decimal.to_string(record.income) == "5000"
      assert Decimal.to_string(record.expenses) == "2000"
      assert Decimal.to_string(record.credit_limit) == "36000"
    end

    test "returns error changeset for missing required fields" do
      assert {:error, changeset} = SalaryRecords.create(%{})

      assert %{
               user_id: ["can't be blank"],
               income: ["can't be blank"],
               expenses: ["can't be blank"],
               credit_limit: ["can't be blank"]
             } = errors_on(changeset)
    end
  end

  describe "get/1 and get!/1" do
    test "retrieves a record by id" do
      record = Factory.insert(:salary_record)
      assert fetched = SalaryRecords.get(record.id)
      assert fetched.id == record.id
      assert_raise Ecto.NoResultsError, fn -> SalaryRecords.get!("0") end
    end
  end

  describe "update/2" do
    test "updates a salary record successfully" do
      record = Factory.insert(:salary_record)
      {:ok, updated} = SalaryRecords.update(record, %{income: "6000"})
      assert Decimal.to_string(updated.income) == "6000"
    end
  end
end
