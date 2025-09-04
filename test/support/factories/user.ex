defmodule CreditApp.Factories.User do
  def user_factory do
    %{
      name: "Test User",
      email: "user#{System.unique_integer([:positive])}@example.com",
      credit_points: 0,
      approval_status: false
    }
  end
end
