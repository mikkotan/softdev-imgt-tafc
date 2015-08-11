class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def create
    Employee.create(employee_params)

    redirect_to '/employees'
  end

  private
  
  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :username)
  end

end
