class ProvisionalReceiptsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @provisional_receipt = ProvisionalReceipt.new
    @provisional_receipt.transaction_id = params[:id]
  end

  def create
    @pr = ProvisionalReceipt.new(provisional_receipt_params)
    @transaction = Transaction.find(@pr.transaction_id)
    @transaction.pay(@pr.receipt_no,@pr.amount_paid, @pr.note)

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
