defmodule CreditAppWeb.SalaryController do
  use CreditAppWeb, :controller
  import Phoenix.Component

  alias CreditApp.Operations.CreditCalculator
  alias CreditApp.Operations.Email
  alias CreditApp.Operations.SalaryRecords
  alias CreditApp.Operations.User, as: UserOperations

  alias CreditApp.Models.User

  def show(conn, %{"id" => id}) do
    case UserOperations.get_user(id) do
      nil ->
        conn
        |> put_flash(:error, "User not found")
        |> redirect(to: ~p"/")

      %User{} = user ->
        salary_form = to_form(%{}, as: "salary")
        render(conn, :show, user: user, salary: salary_form)
    end
  end

  def update(conn, %{"id" => id, "salary" => %{"income" => income, "expenses" => expenses}}) do
    with %User{} = user <- UserOperations.get_user(id),
         {:ok, credit_limit} <- CreditCalculator.call(income, expenses),
         {:ok, salary_record} <-
           SalaryRecords.create(%{
             user_id: user.id,
             income: Decimal.new(income),
             expenses: Decimal.new(expenses),
             credit_limit: credit_limit
           }),
         :ok <- Email.send(user, salary_record) do
      message =
        "Congratulations, you have been approved for credit up to $#{Decimal.to_string(credit_limit)}"

      conn
      |> put_flash(:info, message)
      |> redirect(to: ~p"/")
    else
      nil ->
        conn
        |> put_flash(:error, "User not found")
        |> redirect(to: ~p"/")

      {:error, reason} ->
        conn
        |> put_flash(:error, "Operation failed: #{inspect(reason)}")
        |> redirect(to: ~p"/")
    end
  end
end
