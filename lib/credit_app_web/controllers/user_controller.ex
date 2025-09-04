defmodule CreditAppWeb.UserController do
  use CreditAppWeb, :controller

  import Phoenix.Component, only: [to_form: 1]

  alias CreditApp.Accounts
  alias CreditApp.Accounts.User

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    form = to_form(changeset)
    render(conn, :new, changeset: form)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: ~p"/survey/#{user.id}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: to_form(changeset))
    end
  end
end
