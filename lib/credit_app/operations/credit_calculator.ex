defmodule CreditApp.Operations.CreditCalculator do
  @denominator_value 12

  @type result :: {:ok, Decimal.t()} | {:error, String.t()}

  @spec call(String.t(), String.t()) :: result()
  def call(income, expenses) do
    with {:ok, income_dec} <- parse_decimal(income),
         {:ok, expenses_dec} <- parse_decimal(expenses) do
      diff = Decimal.sub(income_dec, expenses_dec)

      if Decimal.compare(diff, Decimal.new(0)) == :lt do
        {:error, "Expenses cannot exceed income"}
      else
        credit_limit = Decimal.mult(diff, Decimal.new(@denominator_value))
        {:ok, credit_limit}
      end
    end
  end

  @spec parse_decimal(String.t()) :: result()
  defp parse_decimal(value) do
    try do
      {:ok, Decimal.new(value)}
    rescue
      _ -> {:error, "Invalid number: #{value}"}
    end
  end
end
