class UserMailer < ApplicationMailer
	default from: 'info@telotengo.com'
 
	def welcome_email(name, email)
		@name = name
		@mail = email
		mail(to: @mail, subject: 'Welcome to My Awesome Site')
	end
end
