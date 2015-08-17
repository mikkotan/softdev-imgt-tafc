class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    success = true
    edit_user_params.each do |key, value|
      success &&= @user.update_attribute(key, value)
    end

    if success
      flash[:notice] = 'Successfully updated profile.'
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy
    redirect_to root_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'User successfully created.'
      session[:user_id] ||= @user.id
      redirect_to users_path
    else
      render :new
    end
  end

  def change_password
    @user = User.find(params[:id])
  end

  def update_password
    @user = User.find(params[:id])
    if User.authenticate(@user.username, params[:user][:old_password]) || can?(:manage, User)
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

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :username, :role, :password, :password_confirmation)
  end

  def edit_user_params
    params.require(:user).permit(:last_name, :first_name, :username, :role)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
