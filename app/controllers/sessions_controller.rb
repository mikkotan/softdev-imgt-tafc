class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:username], params[:password])

    if user
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Logged In!'
    else
      flash[:alert] = 'Invalid Username or Password!'
      @username = post_params[:username]
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Successfully Logged Out!'
  end

  private

  def post_params
    params.permit(:username, :password)
  end
end
