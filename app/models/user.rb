class User < ActiveRecord::Base

has_secure_password

before_save{ |user| user.email = user.email.downcase }
before_validation do |user|
	  o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
	 user.name = (0...50).map { o[rand(o.length)] }.join if !user.name or  user.name.blank?
end

validates :name, presence: true, length: { maximum: 40 }
OPA= /\A[\w+\-.]+@[\w+\-.]+\.[a-z]+\z/i
validates :email, presence: true, format: { with:OPA },uniqueness:{ case_sensitive: false }
validates :password, presence: true, length:{ minimum: 8}
validates :password_confirmation, presence: true, length:{minimum: 8}


		def self.name_longer_than_eight ()
            usersmorethan8=User.where("length(name)>8")  
        end
end
