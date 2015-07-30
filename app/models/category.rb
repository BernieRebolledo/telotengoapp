class Category < ActiveRecord::Base
	validates :name, precense: true, uniqueness: true
	has_many :services
end
