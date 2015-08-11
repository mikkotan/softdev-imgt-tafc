class UsersController < ApplicationController
  def view
  end

  def index
  end

  def edit
  end

  def new
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :password, :role)
  end
end
