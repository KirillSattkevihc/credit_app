defmodule CreditAppWeb.SalaryController do
  use CreditAppWeb, :controller
  import Phoenix.Component

  alias CreditApp.Accounts
  alias CreditApp.Email

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    salary_form = to_form(%{}, as: "salary")

    render(conn, :show,
      user: user,
      salary: salary_form
    )
  end

  def update(conn, %{"id" => id, "salary" => %{"income" => income, "expenses" => expenses}}) do
    user = Accounts.get_user!(id)

    income_dec = Decimal.new(income)
    expenses_dec = Decimal.new(expenses)
    diff = Decimal.sub(income_dec, expenses_dec)
    credit_limit = Decimal.mult(diff, Decimal.new(12))

    Email.send_pdf(user, credit_limit)

    message = "Congratulations, you have been approved for credit up to $#{credit_limit}"

    conn
    |> put_flash(:info, message)
    |> redirect(to: ~p"/")
  end
end
