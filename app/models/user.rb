class User < ActiveRecord::Base
	validates :email, precense: true, uniqueness: true
	validates :name, precense: true, on: :create
	validates :password, precense: true, length: { minimun: 4}, unless: :provider_uid?
	has_many :services
end
