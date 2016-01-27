class ClientsController < ApplicationController
  before_action :find_client, only: [:show, :edit, :destroy, :update]
  after_filter 'save_my_previous_url', only: [:new]
  load_and_authorize_resource
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "Clients List", clients_path
  end

  def show
    add_breadcrumb "Clients List", clients_path
    add_breadcrumb @client.company_name, client_path
    @transactions = @client.transactions
    @transaction = Transaction.new
  end

  def new
    add_breadcrumb "Clients List", clients_path
    add_breadcrumb "New Client", new_client_path
    @employees = get_employees
    @client = Client.new

    if params[:id]
      @client.user_id = params[:id]
      @withparams = true
    end
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:success] = 'Client successfully added.'
      redirect_to session[:my_previous_url]
    else
      flash[:notice] = 'Client WAS NOT added.'
      render :new
    end
  end

  def edit
    add_breadcrumb "Clients Lists", clients_path
    add_breadcrumb "Edit " + @client.company_name , edit_client_path
    @employees = get_employees
  end

  def destroy
    @client.destroy

    if @client.destroyed?
      flash[:success] = 'Client successfully deleted.'
    else
      flash[:error] = 'Client WAS NOT deleted.'
    end
    redirect_to clients_path
  end

  def update
    if @client.update(client_params)
      flash[:success] = 'Client successfully updated.'
      redirect_to clients_path
    else
      flash[:error] = 'Client WAS NOT edited.'
      render :edit
    end
  end

  def assign
    add_breadcrumb "Clients Lists", clients_path
    add_breadcrumb @client.company_name , clients_assign_path

  end

  private

  def client_params
    params.require(:client).permit(:company_name, :owner, :representative, :address, :tel_num, :email, :tin_num, :status, :user_id)
  end

  def find_client
    @client = Client.find(params[:id])
  end

  def save_my_previous_url
    session[:my_previous_url] = URI(request.referer || '').path
  end
end
