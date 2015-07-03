class UserMailer < ApplicationMailer
	default from: 'info@telotengo.com'
 
	def welcome_email(name, email)
		@name = name
		@mail = email
		mail(to: @mail, subject: 'Welcome to My Awesome Site')
	end

	def email_verifier(name, email, url)
		@name = name
		@mail = email
		@url = url
		mail(to: @mail, subject: 'Verifica tu cuenta')
	end

end
