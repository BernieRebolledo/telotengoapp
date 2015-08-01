class CategoriesController < ApplicationController
	
	def index
		render "index"
	end

	def create

		@category = Category.new(category_params)
		if @category.save
			flash[:notice_succes] = "La categoría ha sido creada."
			redirect_to "/categories"
		else
			flash[:notice_fail] = "La categoría ya existe!!"
			redirect_to "/categories"
		end
	end

	def edit

	end

	def show
		@category = Category.find(params[:id])
		@services_category = Service.where(category_id: params[:id])
		render "categorias"
	end

	def destroy

	end

	private

	def category_params
		params.require(:category).permit(:name, :description)
	end

end
