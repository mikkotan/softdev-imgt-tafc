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
    if User.authenticate(@user.username, params[:user][:old_password]) || can?(:manage, User)
      if @user.update(user_params)
        flash[:notice] = 'Successfully updated profile.'
        redirect_to root_url
      else
        render :edit
      end
    else
      flash[:notice] = 'Wrong Password'
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
      redirect_to users_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :username, :role, :password, :password_confirmation)
  end
end
