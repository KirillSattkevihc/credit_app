defmodule CreditApp.Operations.CreditPointsCalculator do
  alias CreditApp.Operations.User

  @answer_weights %{
    "q1" => 4,
    "q2" => 2,
    "q3" => 2,
    "q4" => 1,
    "q5" => 2
  }

  @type user :: User.t()
  @type points :: non_neg_integer()
  @type result :: {:ok, boolean()} | {:error, any()}

  @spec call(map()) :: points()
  def call(params) do
    Enum.reduce(@answer_weights, 0, fn {q, weight}, acc ->
      if params[q] == "yes", do: acc + weight, else: acc
    end)
  end

  @spec update_user_status(user(), points()) :: result()
  def update_user_status(user, points) do
    credit_approved? = approved?(points)

    case User.update_user(user, %{credit_points: points, approval_status: credit_approved?}) do
      {:ok, _user} -> {:ok, credit_approved?}
      {:error, reason} -> {:error, reason}
    end
  end

  @spec approved?(points()) :: boolean()
  defp approved?(points), do: points > 6
end
