class EmployeesController < ApplicationController
  def index
    @employees = Employees.all
  end

  def show
    @employee = Employees.find(params[:id])
  end

  def new
    @employee = Employees.new
  end

  def create
    Employees.create(employee_params)

    redirect_to '/employees'
  end

  private
  
  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :username)
  end

end
