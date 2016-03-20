class ProvisionalReceiptsController < ApplicationController
  after_filter 'save_my_previous_url', only: [:destroy]
  add_breadcrumb "Home", :root_path

  def index
  end

  def show
  end

  def new
    @provisional_receipt = ProvisionalReceipt.new
    @provisional_receipt.transaction_id = params[:transaction_id]
    @transaction = Transaction.find(@provisional_receipt.transaction_id)
    @client = Client.find(@transaction.client_id)

    add_breadcrumb "Clients List", clients_path
    add_breadcrumb @client.company_name, client_path {@client.id}
    add_breadcrumb "Transaction No. #{@transaction.billing_num}", transaction_path {@client.id @transaction.id}
    add_breadcrumb "New Payment", new_provisional_receipts_path
  end

  def create
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
    @provisional_receipt = ProvisionalReceipt.find params[:provisional_receipt_id]
    @provisional_receipt.transaction_id = params[:transaction_id]
    @transaction = Transaction.find @provisional_receipt.transaction_id
    @client = Client.find @transaction.client_id
    add_breadcrumb "Clients List", clients_path
    add_breadcrumb @client.company_name, client_path {@client.id}
    add_breadcrumb "Transaction No. #{@transaction.billing_num}", transaction_path {@client.id @transaction.id}
  end

  def update
    @provisional_receipt = ProvisionalReceipt.find params[:provisional_receipt_id]
    @transaction = Transaction.find params[:transaction_id]
    @client = Client.find @transaction.client_id
    if @provisional_receipt.update(provisional_receipt_params)
      flash[:success] = 'Payment successfully updated.'
      redirect_to transaction_path {@client.id @transaction.id}
    else
      flash[:error] = 'Payment WAS NOT updated.'
      render :edit
    end
  end

  def destroy
    @provisional_receipt.destroy

    if @provisional_receipt.destroyed?
      flash[:success] = 'Payment successfully deleted.'
    else
      flash[:error] = 'Payment WAS NOT deleted.'
    end
    redirect_to session[:my_previous_url]

  end

  private
  def provisional_receipt_params
    params.require(:provisional_receipt).permit(:transaction_id, :receipt_no, :amount_paid, :note)
  end

  def save_my_previous_url
    session[:my_previous_url] = URI(request.referer || '').path
  end

end
