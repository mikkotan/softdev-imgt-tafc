class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy, :change_password, :update_password]
  before_filter :require_authorization
  load_and_authorize_resource

  def index
    @users = User.page(params[:page])
  end

  def employees
    @employees = get_employees
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
      flash[:notice] = 'Successfully updated profile.'
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'User successfully created.'
      redirect_to users_path
    else
      render :new
    end
  end

  def change_password
  end

  def update_password
    if User.authenticate(@user.email, params[:user][:old_password]) || can?(:manage, User)
      if @user.update(user_params)
        flash[:notice] = 'Successfully updated password.'
        redirect_to root_url
      else
        render :change_password
      end
    else
      flash[:notice] = 'Wrong Password'
      render :change_password
    end
  end

  def clients
    @clients = User.find(params[:id]).clients
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

  def require_authorization
    if can? :read, :all

    else
      flash[:alert] = 'Unauthorized! login ples'
      redirect_to '/login'
    end
  end
end
