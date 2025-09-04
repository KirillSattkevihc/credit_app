defmodule CreditApp.Operations.EmailTest do
  use CreditApp.DataCase, async: true
  import Swoosh.TestAssertions

  alias CreditApp.Operations.Email
  alias CreditApp.Factory

  describe "send/2" do
    test "delivers email with PDF attachment" do
      user = Factory.insert(:user)
      salary_record = Factory.insert(:salary_record, %{user_id: user.id})

      assert :ok = Email.send(user, salary_record)

      assert_email_sent(
        to: {user.name, user.email},
        from: {"CreditApp", "no-reply@creditapp.com"},
        subject: "Your Credit Summary"
      )
    end
  end
end
