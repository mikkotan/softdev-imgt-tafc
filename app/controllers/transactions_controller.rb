class TransactionsController < ApplicationController
  load_and_authorize_resource
  after_filter 'save_my_previous_url', only: [:new]


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
    @transaction.client_id = params[:id]
    @transaction.other_processing_fees.build
    @services = get_services
  end

  def create

    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      redirect_to session[:my_previous_url]
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
    params.require(:transaction).permit(:billing_num,
                                        :retainers_fee,
                                        :vat,
                                        :percentage,
                                        :withholding_1601c,
                                        :withholding_1601e,
                                        :employee_benefit_sss,
                                        :employee_benefit_philhealth,
                                        :employee_benefit_pagibig,
                                        :client_id,
                                        other_processing_fees_attributes: [:id])
  end

  def save_my_previous_url
    session[:my_previous_url] = URI(request.referer || '').path
  end
end
