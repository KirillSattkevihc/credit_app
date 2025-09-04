defmodule CreditApp.Factories.SalaryRecord do
  alias CreditApp.Factory

  def salary_record_factory(attrs \\ %{}) do
    user = Map.get(attrs, :user) || Factory.insert(:user)

    %{
      income: Decimal.new("5000"),
      expenses: Decimal.new("2000"),
      credit_limit: Decimal.new("36000"),
      user_id: user.id
    }
  end
end
