class CategoriesController < ApplicationController
	
	def index
		render "index"
	end

	def create

		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "La categoría ha sido creada."
			redirect_to @category
		else
			flash[:notice] = "La categoría no se pudo crear."
		end
	end

	def edit

	end

	def show
		if session[:category]
			@category = Category.find(session[:category])
			render "categorias"
		else
			redirect_to "index"
		end
	end

	def destroy

	end

	private

	def category_params
		params.require(:category).permit(:name, :description)
	end

end
