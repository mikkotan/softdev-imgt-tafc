class ReportsController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "Reports", reports_path
  end

  def accounts_receivable
    add_breadcrumb "Reports", reports_path
    add_breadcrumb "Accounts Receivables", reports_accounts_receivable_path

    if params[:start] && params[:end]
      @start = Date.parse(params[:start]).beginning_of_day
      @end = Date.parse(params[:end]).end_of_day
      puts @start
      puts @end

      @transactions = Transaction.filtered_pending_transactions(@start, @end)
    else
      puts "Wala sya params"
      @transactions = Transaction.pending_transactions
    end

  end

  def employees_report
    add_breadcrumb "Reports", reports_path
    add_breadcrumb "Employee Reports", reports_employees_report_path
    @employees = get_employees
  end

  def transactions_report
    @transactions = Transaction.all
    add_breadcrumb "Reports", reports_path
    add_breadcrumb "Transaction Reports", reports_transactions_report_path
  end

  def services_report
    @clients = Client.all
    add_breadcrumb "Reports"
    add_breadcrumb "Services Reports", reports_services_report_path
  end
end
