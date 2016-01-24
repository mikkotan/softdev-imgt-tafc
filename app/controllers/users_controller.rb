class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy, :change_password, :update_password, :clients]
  load_and_authorize_resource

  def index
    add_breadcrumb "Home", :root_path
  end

  def employees
    @employees = get_employees
      add_breadcrumb "employees", employees_path
  end

  def show_employee
    @employee = User.find(params[:id])
    @clients = @employee.clients
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update_info edit_user_params
      flash[:success] = 'Successfully updated profile.'
      redirect_to '/home'
    else
      flash[:error] = 'Something went wrong when updating profile.'
      render :edit
    end
  end

  def destroy
    @user.destroy

    if @user.destroyed?
      flash[:success] = 'User successfully deleted.'
    else
      flash[:error] = 'User WAS NOT deleted.'
    end
    redirect_to root_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User successfully created.'
      redirect_to users_path
    else
      flash[:error] = 'User WAS NOT created.'
      render :new
    end
  end

  def change_password
  end

  def update_password
    if User.authenticate(@user.email, params[:user][:old_password]) || can?(:manage, User)
      if @user.update(user_params)
        flash[:success] = 'Successfully updated password.'
        redirect_to root_url
      else
        flash[:error] = 'Something went wrong.'
        render :change_password
      end
    else
      flash[:error] = 'Wrong Password'
      render :change_password
    end
  end

  def clients
    @clients = @user.clients
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :role, :password, :password_confirmation)
  end

  def edit_user_params
    params.require(:user).permit(:last_name, :first_name, :email, :role)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
