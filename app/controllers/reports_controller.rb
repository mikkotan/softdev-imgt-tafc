class ReportsController < ApplicationController
  add_breadcrumb "Home", :root_path

  def accounts_receivable
    add_breadcrumb "Reports"
    add_breadcrumb "Accounts Receivables", reports_accounts_receivable_path
    @transactions = Transaction.pending_transactions
  end

  def employees_report
    add_breadcrumb "Reports"
    add_breadcrumb "Employee Reports", reports_employees_report_path
    @employees = get_employees
  end

  def transactions_report
    @transactions = Transaction.all
    add_breadcrumb "Reports"
    add_breadcrumb "Transaction Reports", reports_transactions_report_path
  end
end
