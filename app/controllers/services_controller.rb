class ServicesController < ApplicationController

	def index
		render "index"
	end

	def create
		@service = Service.new(service_params)
		if @service.save
			flash[:notice_success] = "El servicio ha sido creada."
			redirect_to "/services"
		else
			flash[:notice_fail] = "El servicio no se pudo crear intenta de nuevo"
			redirect_to "/services"
		end
	end

	def edit

	end

	def show

	end

	def destroy
		
	end
	
	private

	def service_params
		params.require(:service).permit(:name, :description, :price, :company, :count)
	end

end
