class TransactionsController < ApplicationController
  load_and_authorize_resource
  after_filter 'save_my_previous_url', only: [:new]
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "Transactions List", transactions_path
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:transaction_id])
    @payments = get_payments(@transaction.id)
    @client = Client.find(@transaction.client_id)
    @provisional_receipt = ProvisionalReceipt.new
    add_breadcrumb "Clients List", clients_path
    add_breadcrumb @client.company_name, client_path {@client.id}
    # add_breadcrumb "Transaction No. #{@transaction.billing_num}", transaction_path {@client.id}, {@transaction.id}
    add_breadcrumb "Transaction No. #{@transaction.billing_num}", transaction_path {@client.id @transaction.id}
  end

  def new
    @transaction = Transaction.new
    @transaction.client_id = params[:id]
    @client = Client.find(@transaction.client_id)
    @transaction.other_processing_fees.build
    @services = get_services
    puts @client.company_name
    puts @client.id
    add_breadcrumb "Clients List", clients_path
    add_breadcrumb @client.company_name, client_path {@client.id}
    add_breadcrumb "New Transaction", new_transaction_path {@transaction.client_id}


  end

  def create
    add_breadcrumb "Transactions List", transactions_path
    @transaction = Transaction.new(transaction_params)

    unless @transaction.save
      @services = get_services
      render :new
      return
    end

    if params[:selectize]
      params[:selectize].each do |value|
        @transaction.other_processing_fees << Service.find(value).make
      end
    end

    redirect_to session[:my_previous_url]
  end

  def new_payment
    @pr = ProvisionalReceipt.new(provisional_receipt_params)
    @transaction = Transaction.find(@pr.transaction_id)

    if @pr.amount_paid > @transaction.remaining_balance
      raise 'Amount paid is greater than the remaining balance'
    else
      @transaction.pay(@pr.receipt_no,@pr.amount_paid, @pr.note)
    end

    redirect_to transaction_path(@transaction.client_id,@transaction.id)
  end

  def edit
    @services = get_services
    services_id = {}
    @services.each do |service|
        services_id[service.complete_name] = service.id
    end
    puts services_id


    @transaction = Transaction.find params[:transaction_id]
    @selected_services = @transaction.other_processing_fees.collect { |x| services_id[x.complete_name] }
    puts @selected_services
    @client = Client.find params[:id]



    add_breadcrumb "Clients List", clients_path
    add_breadcrumb @client.company_name, client_path {@client.id}
    add_breadcrumb "Edit Transaction No. #{@transaction.billing_num}", transaction_path {@client.id @transaction.id}
  end

  def update
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
                                        :discount,
                                        :client_id)
  end

  def save_my_previous_url
    session[:my_previous_url] = URI(request.referer || '').path
  end
end
