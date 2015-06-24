class UserMailer < ApplicationMailer
	default from: 'notifications@telotengo.com'
 
	def welcome_email(name, mail)
		@name = name
		@mail = mail
		mail(to: mail, subject: 'Welcome to My Awesome Site')
	end
end
