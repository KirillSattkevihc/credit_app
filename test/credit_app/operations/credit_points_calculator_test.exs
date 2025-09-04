defmodule CreditApp.Operations.CreditPointsCalculatorTest do
  use CreditApp.DataCase, async: true

  alias CreditApp.Factory
  alias CreditApp.Operations.CreditPointsCalculator
  alias CreditApp.Operations.User

  describe "call/1" do
    test "calculates points correctly" do
      params = %{"q1" => "yes", "q2" => "no", "q3" => "yes", "q4" => "no", "q5" => "yes"}
      assert CreditPointsCalculator.call(params) == 8
    end
  end

  describe "update_user_status/2" do
    test "approves user if points > 6" do
      user = Factory.insert(:user)

      assert {:ok, true} = CreditPointsCalculator.update_user_status(user, 8)

      updated_user = User.get_user!(user.id)
      assert updated_user.credit_points == 8
      assert updated_user.approval_status == true
    end

    test "does not approve user if points <= 6" do
      user = Factory.insert(:user)

      assert {:ok, false} = CreditPointsCalculator.update_user_status(user, 5)

      updated_user = User.get_user!(user.id)
      assert updated_user.credit_points == 5
      assert updated_user.approval_status == false
    end
  end
end
