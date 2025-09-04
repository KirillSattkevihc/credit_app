defmodule CreditApp.Factory do
  alias CreditApp.Repo

  @factories %{
    user: {CreditApp.Models.User, &CreditApp.Factories.User.user_factory/0},
    salary_record:
      {CreditApp.Models.SalaryRecord, &CreditApp.Factories.SalaryRecord.salary_record_factory/1}
  }

  def insert(factory_name, attrs \\ %{}) do
    {module, factory_fun} = Map.fetch!(@factories, factory_name)

    base_attrs =
      case Function.info(factory_fun)[:arity] do
        0 -> factory_fun.()
        1 -> factory_fun.(attrs)
      end

    entity = struct(module, Map.merge(base_attrs, attrs))
    Repo.insert!(entity)
  end
end
