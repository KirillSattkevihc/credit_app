defmodule CreditApp.PDF.Templates.CreditSummary do
  alias CreditApp.Models.{User, SalaryRecord}

  @spec render(User.t(), SalaryRecord.t()) :: String.t()
  def render(%User{} = user, %SalaryRecord{} = record) do
    """
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <title>Credit Summary</title>
      <style>
        body {
          font-family: Arial, sans-serif;
          margin: 40px;
          color: #333;
        }
        h1 {
          color: #2c3e50;
          margin-bottom: 10px;
        }
        h2 {
          margin-top: 30px;
          font-size: 18px;
          border-bottom: 1px solid #ccc;
          padding-bottom: 5px;
        }
        p {
          font-size: 16px;
          line-height: 1.5;
        }
        table {
          width: 100%;
          border-collapse: collapse;
          margin-top: 15px;
        }
        table th, table td {
          border: 1px solid #ccc;
          padding: 8px 12px;
          text-align: left;
        }
        table th {
          background-color: #f4f4f4;
        }
        .status {
          font-weight: bold;
          color: #{if user.approval_status, do: "green", else: "red"};
        }
      </style>
    </head>
    <body>
      <h1>Credit Summary for #{user.name}</h1>
      <p>Dear #{user.name},</p>
      <p>
        We are pleased to provide you with the summary of your credit application.
      </p>

      <h2>User Information</h2>
      <table>
        <tr>
          <th>Email</th>
          <td>#{user.email}</td>
        </tr>
        <tr>
          <th>Credit Points</th>
          <td>#{user.credit_points}</td>
        </tr>
        <tr>
          <th>Approval Status</th>
          <td class="status">
            #{if user.approval_status, do: "Approved ✅", else: "Not Approved ❌"}
          </td>
        </tr>
      </table>

      <h2>Salary Record</h2>
      <table>
        <tr><th>Income</th><td>$#{record.income || 0}</td></tr>
        <tr><th>Expenses</th><td>$#{record.expenses || 0}</td></tr>
        <tr><th>Credit Limit</th><td>$#{record.credit_limit || 0}</td></tr>
        <tr><th>Created At</th><td>#{record.inserted_at}</td></tr>
        <tr><th>Updated At</th><td>#{record.updated_at}</td></tr>
      </table>

      <p style="margin-top:40px; font-size: 14px; color: #777;">
        This document was generated automatically by CreditApp.
      </p>
    </body>
    </html>
    """
  end
end
