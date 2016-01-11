class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
    @fees = @transaction.fees
    @fee = Fee.new
  end

  def new
    @transaction = Transaction.new
  end

  def create

    @transaction = Transaction.new(transaction_params.merge(client_id: params[:id]))

    if @transaction.save
      redirect_to client_path(params)
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def transaction_params
    params.require(:transaction).permit(:retainers_fee, :vat, :percentage)
  end
end
