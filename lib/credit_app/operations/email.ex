defmodule CreditApp.Operations.Email do
  import Swoosh.Email

  alias CreditApp.Mailer
  alias CreditApp.PDF
  alias CreditApp.Models.SalaryRecord
  alias CreditApp.Models.User

  @from {"CreditApp", "no-reply@creditapp.com"}

  @spec send(User.t(), SalaryRecord.t()) :: :ok | {:error, any()}
  def send(%User{} = user, %SalaryRecord{} = salary_record) do
    try do
      do_send(user, salary_record)
      :ok
    rescue
      error -> {:error, error}
    end
  end

  defp do_send(%User{} = user, %SalaryRecord{} = salary_record) do
    pdf_binary = PDF.generate_pdf_binary(user, salary_record)

    new()
    |> to({user.name, user.email})
    |> from(@from)
    |> subject("Your Credit Summary")
    |> html_body("""
      <p>Dear #{user.name},</p>
      <p>Please find attached your credit summary.</p>
    """)
    |> attachment(%Swoosh.Attachment{
      data: pdf_binary,
      filename: "credit_summary_#{salary_record.id}.pdf",
      content_type: "application/pdf"
    })
    |> Mailer.deliver()
  end
end
