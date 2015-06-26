class UsersController < ApplicationController
	
	# Lista de amigos
	def index
		# Compruebo si existe una sesión de usuario.
	  	if session[:user]
	  		# Busco en la tabla de usuarios uno con el id de esa sesión existente.
      		# Se le asigna el valor de la busqueda a la variable de instancia.
	  		@user = User.find(session[:user])
	  	end
	  	# Renderizo la vista index. /views/index.html.erb
	  	render "/index"
  	end

  	# Vista del perfil de usuario
  	def show
  		# Compruebo si existe una sesión de usuario.
  		if session[:user]
  		# Busco en la tabla de usuarios uno con el id de esa sesión existente.
      	# Se le asigna el valor de la busqueda a la variable de instancia.	
  			@user = User.find(session[:user])
  			render "profile"
  		end
  	end

  	# Vista para editar la info de usuario
	def edit
		@user = User.find(session[:user]) if session[:user]
	end

	# Método para guardar datos del usuario nuevo.
	def create
		# Creo una variable de instancia asignandole el valor de un nuevo usuario.
    	# Y pasandole los parametros que admitimos para un usuario.
		@user = User.new(user_params)
		# Verifico si el parametro de la imagen existe y de ser así 
    	# inspeciono el elemento para saber si es un objeto o un cadena de texto.
		# if params[:user][:image] && !params[:user][:image].is_a?(String)
	 #      if @user.image && Dir.glob("public#{@user.image}").count > 0
	 #        File.delete("public#{@user.image}")
	 #      end
	 #      @user.image = "/uploads/users/#{Random.new_seed.to_s}.#{params[:user][:image].original_filename.split(".").last}"
	 #      File.open('public' + @user.image, "wb") do |f|
	 #        f.write(params[:user][:image].read)
	 #      	end
  #   	end
		if @user.save
			session[:user] = @user.id
			flash[:notice] = "Su usuario se ha creado."
			redirect_to @user
		else
			flash[:notice] = "No se puedo crear el usuario intente de nuevo"
			render "/"
		end
	end

	# Método para guardar datos de facebook, twitter.
  	def connect
	  	if env["omniauth.auth"]
	  		@user = User.where(provider_uid: env["omniauth.auth"]["uid"]).first
	  		unless @user
		  		@user = User.new
		  		@user.name = env["omniauth.auth"]["extra"]["raw_info"]["name"]
		  		@user.email = env["omniauth.auth"]["extra"]["raw_info"]["email"]
		  		@user.image = env["omniauth.auth"]["info"]["image"]
		  		@user.gender = env["omniauth.auth"]["extra"]["raw_info"]["gender"]
		  		@user.verified = env["omniauth.auth"]["extra"]["raw_info"]["verified"]
		  		@user.provider_uid = env["omniauth.auth"]["uid"]
		  		if @user.save
		  			session[:user] = @user.id
		  			UserMailer.welcome_email(@user.name, @user.mail).deliver_now
		  		else
		  			flash[:notice] = "Los datos no se pudieron guardar."
		  			redirect_to "/"
		  		end
		  	else
		  		session[:user] = @user.id
				redirect_to "/users/profile"
		  	end
	  	elsif params[:error]
	  		render plain: "#{params[:error]} #{params[:error_reason]}", content_type: "application/plain"
	  	else	
	  		render plain: "No se peudo conectar con #{params[:provider]}", content_type: "application/plain"
	  	end
  	end

  	def login
  		user = User.where(email: user_params[:email]).first
  		if user && user.provider_uid
  			render plain: "Hola #{user.name} puedes indicar sesión por medio de facebook o twitter", content_type: "application/plain"
  		else 	
	  		if user && user.password == user_params[:password]
	  			render "/profile"
	  		end
	  	end
  	end

  	def user_connect

  	end


	# def verificar
	# 	@user = User.find(params[:id])
	# 	@user.verified = true
	# 	if @user.save
	# 	  redirect_to @user
	# 	else
	# 	  render plain: "No se pudo verificar el correo.", content_type: "application/text"
	# 	end
	# end


  	# Método cerrar sesión.
	def destroy
		session[:user] = nil
		redirect_to "/"
	end

	#Método privado para indicar los campos que recibe en método create.
	private

	def user_params
		params.require(:user).permit(:name, :email, :password)
	end


end
