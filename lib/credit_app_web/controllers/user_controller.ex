defmodule CreditAppWeb.UserController do
  use CreditAppWeb, :controller
  import Phoenix.Component, only: [to_form: 1]

  alias CreditApp.Operations.User, as: UserOperations
  alias CreditApp.Models.User

  def new(conn, _params) do
    changeset = UserOperations.change_user(%User{})
    form = to_form(changeset)
    render(conn, :new, changeset: form)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, user} <- UserOperations.create_user(user_params) do
      conn
      |> put_flash(:info, "User created successfully.")
      |> redirect(to: ~p"/survey/#{user.id}")
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: to_form(changeset))

      {:error, reason} ->
        conn
        |> put_flash(:error, "Failed to create user: #{inspect(reason)}")
        |> redirect(to: ~p"/")
    end
  end
end
