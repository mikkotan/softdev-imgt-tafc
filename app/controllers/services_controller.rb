class ServicesController < ApplicationController
  before_action :find_service, only: [:show, :edit, :destroy, :update]
  load_and_authorize_resource

  def index
    
  end

  def new
    @service = Service.new
    @service.related_costs.build
  end

  def create
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
