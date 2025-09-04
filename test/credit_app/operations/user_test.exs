defmodule CreditApp.Operations.UserTest do
  use CreditApp.DataCase, async: true

  alias CreditApp.Models.User
  alias CreditApp.Factory

  @subject CreditApp.Operations.User

  describe "change_user/2" do
    test "returns a changeset" do
      user = Factory.insert(:user)
      changeset = @subject.change_user(user, %{})
      assert %Ecto.Changeset{} = changeset
    end
  end

  describe "create_user/1" do
    test "creates user with valid attributes" do
      {:ok, user} = @subject.create_user(%{name: "Name", email: "testemail@a.com"})
      assert %User{} = user
      assert "Name" == user.name
      assert "testemail@a.com" == user.email
    end

    test "returns error changeset for invalid attributes" do
      attrs = %{name: "123", email: "invalid_email"}
      assert {:error, changeset} = @subject.create_user(attrs)

      assert %{
               name: ["Name must contain only letters and spaces"],
               email: ["Invalid email format"]
             } =
               errors_on(changeset)
    end
  end

  describe "get_user/1 and get_user!/1" do
    test "returns nil for get_user when user does not exist" do
      assert @subject.get_user("0") == nil
    end

    test "returns the user for get_user" do
      user = Factory.insert(:user)
      assert fetched = @subject.get_user(user.id)
      assert fetched.id == user.id
    end

    test "raises for get_user! when user does not exist" do
      assert_raise Ecto.NoResultsError, fn ->
        @subject.get_user!("0")
      end
    end
  end

  describe "update_user/2" do
    test "updates user successfully" do
      user = Factory.insert(:user)
      {:ok, updated_user} = @subject.update_user(user, %{name: "Updated Name"})
      assert updated_user.name == "Updated Name"
    end

    test "returns error changeset for invalid update" do
      user = Factory.insert(:user)
      {:error, changeset} = @subject.update_user(user, %{email: "bad_email"})
      assert %{email: ["Invalid email format"]} = errors_on(changeset)
    end
  end
end
