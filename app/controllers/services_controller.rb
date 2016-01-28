class ServicesController < ApplicationController
  before_action :find_service, only: [:show, :edit, :destroy, :update]
  load_and_authorize_resource
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "Services List", services_path
  end

  def new
    add_breadcrumb "Services List", services_path
    add_breadcrumb "Add Service", new_service_path
    @service = Service.new
    @service.related_costs.build
  end

  def create
    add_breadcrumb "Services List", services_path
    add_breadcrumb "Add Service", new_service_path
    @service = Service.new(service_params)

    if @service.save
      flash[:success] = 'Service successfully added.'
      redirect_to services_path
    else
      flash[:error] = 'Service WAS NOT added.'
      render :new
    end
  end

  def edit
    add_breadcrumb "Services List", services_path
    add_breadcrumb "Edit Service " + @service.complete_name, edit_service_path
    @service = Service.find params[:id]
    @service.related_costs.build if @service.related_costs.size == 0
  end

  def update
    if @service.update(service_params)
      flash[:success] = 'Service successfully updated.'
      redirect_to services_path
    else
      flash[:error] = 'Service WAS NOT updated.'
      render :edit
    end
  end

  def destroy
    @service.destroy

    if @service.destroyed?
      flash[:success] = 'Service successfully deleted.'
    else
      flash[:error] = 'Service WAS NOT deleted.'
    end
    redirect_to services_path
  end

  private

  def service_params
    params.require(:service).permit(:name, :monthly_fee, related_costs_attributes: [:nature, :value, :service])
  end

  def find_service
    @service = Service.find(params[:id])
  end
end
