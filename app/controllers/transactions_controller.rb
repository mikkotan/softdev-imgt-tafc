class TransactionsController < ApplicationController
  load_and_authorize_resource

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
  end
end
