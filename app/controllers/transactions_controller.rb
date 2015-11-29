class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def transaction_params

  end
end
