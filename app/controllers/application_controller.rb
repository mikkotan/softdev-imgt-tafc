class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :save_current_url

  helper_method :get_employees
  helper_method :current_user

  rescue_from CanCan::AccessDenied do |_exception|
    flash[:alert] = 'You are unauthorized!'
    redirect_to session.delete(:return_to)
  end

  private
  def save_current_url
    session[:return_to] = request.referer
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def get_employees
    @employees = User.where('role = ?', 'employee')
  end

  def get_services
    @service = Service.where('is_template = ?', true)
  end

  def get_payments(id)
    @payments = ProvisionalReceipt.where('transaction_id = ?', id)
  end
end
