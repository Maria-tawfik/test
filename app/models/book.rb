class Book < ActiveRecord::Base
	validates :name ,:presence =>true
	belongs_to :author
	belongs_to :library
end
