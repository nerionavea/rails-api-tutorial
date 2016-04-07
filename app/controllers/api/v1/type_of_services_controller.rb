class Api::V1::TypeOfServicesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]
  respond_to :json

  def create
    type_of_service = current_user.type_of_services.build(type_of_service_params)
    if type_of_service.save
      render json: type_of_service, status: 201, location: [:api, type_of_service]
    else
      render json: {errors: type_of_service.errors}, status: 422
    end
  end

  def destroy
    type_of_service = current_user.type_of_services.find(params[:id])
    type_of_service.destroy
    head 204
  end

  def index
    respond_with TypeOfService.all
  end

  def show
    respond_with TypeOfService.find(params[:id])
  end

  def update
    type_of_service = current_user.type_of_services.find(params[:id])
    if type_of_service.update(type_of_service_params)
      render json: type_of_service, status: 200, location: [:api, type_of_service]
    else
      render json: {errors: type_of_service.errors}, status: 422
    end
  end

  private
    def type_of_service_params
      params.require(:type_of_service).permit(:description, :standart_kms, :standart_days, :sms_model)
    end
end
