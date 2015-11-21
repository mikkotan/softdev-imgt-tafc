class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Logged In!'
    else
      flash[:alert] = 'Invalid Email or Password!'
      @email = post_params[:email]
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Successfully Logged Out!'
  end

  private

  def post_params
    params.permit(:email, :password)
  end
end
