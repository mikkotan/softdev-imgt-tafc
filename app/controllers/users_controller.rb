class UsersController < ApplicationController
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

  def create
    if User.create(user_params)
      redirect_to :index
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :username, :role, :password)
  end
end
