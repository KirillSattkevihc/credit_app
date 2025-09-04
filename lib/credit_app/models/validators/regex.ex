defmodule CreditApp.Models.Validators.Regex do
  @type name_regex :: Regex.t()
  @name_regex ~r/^[a-zA-Z\s]+$/

  @type email_regex :: Regex.t()
  @email_regex ~r/^[\w._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/

  @spec name_regex() :: name_regex()
  def name_regex, do: @name_regex

  @spec email_regex() :: email_regex()
  def email_regex, do: @email_regex
end
