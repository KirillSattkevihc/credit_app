defmodule CreditApp.PDF do
  alias CreditApp.Models.SalaryRecord
  alias CreditApp.Models.User

  def generate_pdf_binary(%User{} = user, %SalaryRecord{} = salary_record) do
    html = __MODULE__.Templates.CreditSummary.render(user, salary_record)

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
