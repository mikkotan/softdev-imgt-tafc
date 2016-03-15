class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy, :change_password, :update_password, :clients]
  load_and_authorize_resource
  add_breadcrumb "Home", :root_path

  def index
  end

  def employees
    add_breadcrumb "Employees", employees_path
    @employees = get_employees

  end

  def show_employee
    @employee = User.find(params[:id])
    @clients = @employee.clients
    add_breadcrumb "Employees", employees_path
    add_breadcrumb @employee.email, show_employee_path
  end

  def show
  end

  def new
    add_breadcrumb "Employees", employees_path
    add_breadcrumb "New User", new_user_path
    @user = User.new
  end

  def edit
    add_breadcrumb "Employees", employees_path
    add_breadcrumb "Edit " + @user.email
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
    add_breadcrumb "Employees", employees_path
    add_breadcrumb "New User", new_user_path
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
    add_breadcrumb "Employees", employees_path
    add_breadcrumb "Change Password of " + @user.email , change_password_path
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
