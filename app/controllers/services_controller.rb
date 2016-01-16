class ServicesController < ApplicationController
  before_action :find_service, only: [:show, :edit, :destroy, :update]

  def index
    @services = Service.all
  end

  def new
    @service = Service.new
    @service.related_costs.build
  end

  def create
    @service = Service.new(service_params)
    p @service.monthly_fee

    if @service.save
      flash[:notice] = 'Service successfully added.'
      redirect_to services_path
    else
      render :new
    end
  end

  def edit
    @service = Service.find params[:id]
    @service.related_costs.build if @service.related_costs.size == 0
  end

  def update
    if @service.update(service_params)
      flash[:notice] = 'Service successfully updated.'
      redirect_to services_path
    else
      render :edit
    end
  end

  def destroy
    @service.destroy
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
