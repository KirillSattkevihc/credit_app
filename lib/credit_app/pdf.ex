defmodule CreditApp.PDF do
  alias CreditApp.Accounts.User

  def generate_pdf_binary(%User{} = user, credit_limit) do
    html = """
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <title>Credit Summary</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 40px; }
          h1 { color: #333; }
          p { font-size: 16px; line-height: 1.5; }
        </style>
      </head>
      <body>
        <h1>Credit Summary for #{user.name}</h1>
        <p> Congratulations, you have been approved for credit up to $#{credit_limit || 0.0}</p>
      </body>
      </html>
    """

    {:ok, pdf_binary} =
      PdfGenerator.generate_binary(
        html,
        page_size: "A4",
        shell_params: ["--encoding", "UTF-8"],
        filename: "credit_summary_#{user.id}.pdf"
      )

    pdf_binary
  end
end
