class ServicesController < ApplicationController

	def index
		@user = User.find(session[:user])
		render "index"
	end

	def create
		@service = Service.new(service_params)
		@service.user_id = session[:user]
		@service.category_id = service_params[:category_id]
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
		params.require(:service).permit(:name, :description, :price, :company, :count, :category_id)
	end

end
