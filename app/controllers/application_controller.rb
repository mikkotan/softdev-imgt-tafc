class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :employees
  helper_method :current_user

  rescue_from CanCan::AccessDenied do |_exception|
    flash[:notice] = 'You are unauthorized!'
    redirect_to '/login'
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def get_employees
    @employees = User.where('role = ?', 'employee')
  end
  


end
