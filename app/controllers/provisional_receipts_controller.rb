class ProvisionalReceiptsController < ApplicationController
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

    redirect_to transaction_path(@transaction.id)
  end

  def edits
  end

  def update
  end

  def destroy
  end

  private
  def provisional_receipt_params
    params.require(:provisional_receipt).permit(:transaction_id, :receipt_no, :amount_paid, :note)
  end

end
