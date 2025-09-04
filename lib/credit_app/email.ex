defmodule CreditApp.Email do
  import Swoosh.Email
  alias CreditApp.Mailer
  alias CreditApp.PDF
  alias CreditApp.Accounts.User

  @from {"CreditApp", "no-reply@creditapp.com"}

  def send_pdf(%User{} = user, credit_limit) do
    pdf_binary = PDF.generate_pdf_binary(user, credit_limit)

    new()
    |> to({user.name, user.email})
    |> from(@from)
    |> subject("Your Credit Summary")
    |> html_body("<p>Dear #{user.name}, please find attached your credit summary.</p>")
    |> attachment(%Swoosh.Attachment{
      data: pdf_binary,
      filename: "credit_summary_#{user.id}.pdf",
      content_type: "application/pdf"
    })
    |> Mailer.deliver()
  end
end
