class TransactionsController < ApplicationController
  load_and_authorize_resource
  after_filter 'save_my_previous_url', only: [:new]
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "Transactions List", transactions_path
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
    @payments = get_payments(@transaction.id)
    @client = Client.find(@transaction.client_id)
    @provisional_receipt = ProvisionalReceipt.new

    add_breadcrumb "Clients List", clients_path
    add_breadcrumb @client.company_name, client_path(@client.id)
    add_breadcrumb "Transaction No. #{@transaction.billing_num}"
  end

  def new
    @transaction = Transaction.new
    @transaction.client = Client.find(params[:client_id])
    @client = @transaction.client

    @transaction.other_processing_fees.build
    @services = get_services

    add_breadcrumb "Clients List", clients_path
    add_breadcrumb @client.company_name, client_path(@client.id)
    add_breadcrumb "New Transaction"
    @last_transaction = Transaction.last
    if @last_transaction == nil
      @transaction.billing_num = '00001'
    else
      @transaction.billing_num = @last_transaction.billing_num.succ
    end
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @client = Client.find(@transaction.client_id)

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

    add_breadcrumb "Transactions List", transactions_path
    redirect_to client_path(@client.id)
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

    @transaction = Transaction.find params[:id]
    @selected_services = @transaction.other_processing_fees.collect { |x| services_id[x.complete_name] }
    @client = @transaction.client

    add_breadcrumb "Clients List", clients_path
    add_breadcrumb @client.company_name, client_path(@client.id)
    add_breadcrumb "Edit Transaction No. #{@transaction.billing_num}"
  end

  def update
    @transaction = Transaction.find params[:id]

    if @transaction.update_info transaction_params
      @transaction.other_processing_fees.each { |x| x.destroy }
      if params[:selectize]
        params[:selectize].each do |value|
          @transaction.other_processing_fees << Service.find(value).make
        end
      end

      flash[:success] = 'Successfully updated transaction.'
      redirect_to(@transaction)
    else
      @services = get_services
      services_id = {}
      @services.each do |service|
          services_id[service.complete_name] = service.id
      end
      @selected_services = @transaction.other_processing_fees.collect { |x| services_id[x.complete_name] }
      @client = @transaction.client

      add_breadcrumb "Clients List", clients_path
      add_breadcrumb @client.company_name, client_path(@client.id)
      add_breadcrumb "Edit Transaction No. #{@transaction.billing_num}"

      flash[:error] = 'Something went wrong when updating transaction.'
      render :edit
    end
  end

  def pay
    @transaction = Transaction.find params[:transaction_id]

    a = payment_params
    @transaction.pay a[:receipt_no], a[:amount_paid], a[:note]

    redirect_to @transaction
  end

  def destroy
    @transaction = Transaction.find params[:id]
    @transaction.destroy

    if @transaction.destroyed?
      flash[:success] = 'Service successfully deleted.'
    else
      flash[:error] = 'Service WAS NOT deleted. This transaction may still have payments.'
    end

    redirect_to transactions_path
  end

  private

  def payment_params
    params.require(:provisional_receipt).permit(:receipt_no,
                                                :amount_paid,
                                                :note)
  end

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
