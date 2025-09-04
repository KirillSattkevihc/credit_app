defmodule CreditApp.Operations.User do
  alias CreditApp.Repo
  alias CreditApp.Models.User

  @type user_params :: map()
  @type user_result :: {:ok, User.t()} | {:error, any()}

  @spec change_user(User.t(), user_params()) :: Ecto.Changeset.t()
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @spec create_user(user_params()) :: user_result()
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
    |> handle_repo_result()
  end

  @spec get_user(binary() | number()) :: User.t() | nil
  def get_user(id) do
    Repo.get(User, id)
  end

  @spec get_user!(binary() | number()) :: User.t()
  def get_user!(id) do
    Repo.get!(User, id)
  end

  @spec update_user(User.t(), user_params()) :: user_result()
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
    |> handle_repo_result()
  end

  @spec handle_repo_result({:ok, User.t()} | {:error, Ecto.Changeset.t()}) :: user_result()
  defp handle_repo_result({:ok, user}), do: {:ok, user}
  defp handle_repo_result({:error, %Ecto.Changeset{} = changeset}), do: {:error, changeset}
end
