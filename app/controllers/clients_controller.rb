class ClientsController < ApplicationController
  before_action :find_client, only: [:show, :edit, :destroy, :update]

  def index
    if params[:search]
      @clients = Client.search(params[:search]).order('company_name ASC')
    else
      @clients = Client.all.order('company_name ASC')
    end
  end

  def show
    @client = Client.find(params[:id])
    @transactions = @client.transactions
    @transaction = Transaction.new
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      flash[:notice] = 'Client successfully added.'
      redirect_to clients_path
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    @client.destroy

    redirect_to clients_path
  end

  def update
    if @client.update(client_params)
      flash[:notice] = 'Client successfully updated.'
      redirect_to clients_path
    else
      render :edit
    end
  end

  def assign
  end


  private

  def client_params
    params.require(:client).permit(:company_name, :owner, :representative, :address, :tel_num, :email, :tin_num, :status, :user_id)
  end

  def find_client
    @client = Client.find(params[:id])
  end
end
