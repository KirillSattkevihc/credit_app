defmodule CreditApp.Operations.CreditCalculatorTest do
  use CreditApp.DataCase, async: true

  alias CreditApp.Operations.CreditCalculator

  @subject CreditCalculator

  describe "call/2" do
    test "calculates credit limit correctly for valid income and expenses" do
      {:ok, credit} = @subject.call("5000", "2000")
      expected = Decimal.new(3000) |> Decimal.mult(12)
      assert credit == expected
    end

    test "returns error when expenses exceed income" do
      assert {:error, "Expenses cannot exceed income"} = @subject.call("1000", "2000")
    end

    test "returns error for invalid income format" do
      assert {:error, "Invalid number: abc"} = @subject.call("abc", "1000")
    end

    test "returns error for invalid expenses format" do
      assert {:error, "Invalid number: xyz"} = @subject.call("1000", "xyz")
    end

    test "calculates credit correctly when expenses equal income" do
      {:ok, credit} = @subject.call("2000", "2000")
      expected = Decimal.new(0) |> Decimal.mult(12)
      assert credit == expected
    end
  end
end
