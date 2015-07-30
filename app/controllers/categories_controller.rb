class CategoriesController < ApplicationController
	
	def index
		render "index"
	end

	def create

		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "La categoría ha sido creada."
			redirect_to "/categories"
		else
			flash[:notice] = "La categoría no se pudo crear."
		end
	end

	def edit

	end

	# def show
	# 	@category = Category.find(params[:id])
	# 	render "categorias"
	# end

	def destroy

	end

	private

	def category_params
		params.require(:category).permit(:name, :description)
	end

end
