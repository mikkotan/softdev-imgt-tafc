class TransactionsController < ApplicationController
  load_and_authorize_resource
  after_filter 'save_my_previous_url', only: [:new]
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "Transactions List", transactions_path
    @transactions = Transaction.all
  end

  def show
    add_breadcrumb "Transactions List", transactions_path
    add_breadcrumb "View Transaction (Add transaction name here)", transaction_path
    @transaction = Transaction.find(params[:id])
    @fees = @transaction.get_fees
    @fee = Fee.new
  end

  def new
    add_breadcrumb "Transactions List", transactions_path
    add_breadcrumb "New Transaction", new_transaction_path

    @transaction = Transaction.new
    @transaction.client_id = params[:id]
    @transaction.other_processing_fees.build
    @services = get_services
  end

  def create
    add_breadcrumb "Transactions List", transactions_path
    add_breadcrumb "New Transaction", new_transaction_path
    @transaction = Transaction.new(transaction_params)

    unless @transaction.save
      @services = get_services
      render :new
      return
    end

    params[:services].each do |value|
      @transaction.other_processing_fees << Service.find(value).make
    end

    redirect_to session[:my_previous_url]
  end

  def edit
    add_breadcrumb "Transactions List", transactions_path
    add_breadcrumb "Edit Transaction(add Transaction name here)", edit_transaction_path
  end

  def update
    add_breadcrumb "Transactions List", transactions_path
    add_breadcrumb "Edit Transaction(add Transaction name here)", edit_transaction_path
    @user = User.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to(@transaction, :notice => 'Transaction was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@user) }
      end
    end
  end

  def destroy
  end

  private

  def transaction_params
    params.require(:transaction).permit(:billing_num,
                                        :retainers_fee,
                                        :vat,
                                        :percentage,
                                        :withholding_1601c,
                                        :withholding_1601e,
                                        :employee_benefit_sss,
                                        :employee_benefit_philhealth,
                                        :employee_benefit_pag_ibig,
                                        :client_id)
  end

  def save_my_previous_url
    session[:my_previous_url] = URI(request.referer || '').path
  end
end
