defmodule CreditAppWeb.SurveyController do
  use CreditAppWeb, :controller
  import Phoenix.Component
  alias CreditApp.Accounts

  @answer_weights %{
      "q1" => 4,
      "q2" => 2,
      "q3" => 2,
      "q4" => 1,
      "q5" => 2
    }

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    survey_form = to_form(%{}, as: "survey")

    render(conn, :show,
      user: user,
      survey: survey_form
    )
  end

 def update(conn, %{"id" => id, "survey" => survey_params}) do
    user = Accounts.get_user!(id)
    points = calculate_points(survey_params)

    credit_approved? = points > 6
    
    Accounts.update_user(user, %{credit_points: points, approval_status: credit_approved?})

    if credit_approved? do
      conn
      |> put_flash(:info, "Survey completed. Proceeding to salary entry.")
      |> redirect(to: ~p"/salary/#{user.id}")
    else
      conn
      |> put_flash(:info, "Thank you for your answer. We are currently unable to issue credit to you.")
      |> redirect(to: ~p"/")
    end
  end

  defp calculate_points(params) do
    Enum.reduce(@answer_weights, 0, fn {q, weight}, acc ->
      if params[q] == "yes", do: acc + weight, else: acc
    end)
  end
end
