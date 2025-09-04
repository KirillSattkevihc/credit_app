defmodule CreditAppWeb.SurveyController do
  use CreditAppWeb, :controller
  import Phoenix.Component

  alias CreditApp.Operations.CreditPointsCalculator
  alias CreditApp.Operations.User

  def show(conn, %{"id" => id}) do
    case User.get_user(id) do
      nil ->
        conn
        |> put_flash(:error, "User not found")
        |> redirect(to: ~p"/")

      user ->
        survey_form = to_form(%{}, as: "survey")
        render(conn, :show, user: user, survey: survey_form)
    end
  end

  def update(conn, %{"id" => id, "survey" => survey_params}) do
    with user when not is_nil(user) <- User.get_user(id),
         points <- CreditPointsCalculator.call(survey_params),
         {:ok, credit_approved?} <- CreditPointsCalculator.update_user_status(user, points) do
      if credit_approved? do
        conn
        |> put_flash(:info, "Survey completed. Proceeding to salary entry.")
        |> redirect(to: ~p"/salary/#{user.id}")
      else
        conn
        |> put_flash(
          :info,
          "Thank you for your answer. We are currently unable to issue credit to you."
        )
        |> redirect(to: ~p"/")
      end
    else
      nil ->
        conn
        |> put_flash(:error, "User not found")
        |> redirect(to: ~p"/")

      {:error, reason} ->
        conn
        |> put_flash(:error, "Failed to update user: #{inspect(reason)}")
        |> redirect(to: ~p"/")
    end
  end
end
