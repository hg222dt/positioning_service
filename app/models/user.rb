require 'securerandom'

class User < ActiveRecord::Base
	before_create :generate_access_token

	has_secure_password


	validates 	:email,
				:presence => {:message => "Du måste ange en e-postadress."},
				uniqueness: true

	validates_format_of :email,  :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
						:presence => "Ange en korrekt e-postadress."


	def generate_access_token

		begin
	      self.authkey = SecureRandom.hex
	    end while self.class.exists?(authkey: authkey)

	end


end
