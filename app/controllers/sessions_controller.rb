class SessionsController < ApplicationController
  layout :resolve_layout

  def new
    redirect_to '/home' if current_user
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      flash[:success] = "Logged In!"
      redirect_to '/home'
    else
      flash[:error] = 'Invalid Email or Password!'
      @email = post_params[:email]
      render 'new'
    end
  end
   
  def destroy
    session[:user_id] = nil
    flash[:success] = 'Successfully Logged Out!'
    redirect_to '/login'
  end

  private

  def resolve_layout
    case action_name
    when 'new', 'create'
      'blank_layout'
    else
      'application'
    end
  end

  def post_params
    params.permit(:email, :password)
  end
end
