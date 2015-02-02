class User < ActiveRecord::Base

	has_secure_password

	validates 	:email,
				:presence => {:message => "Du måste ange en e-postadress."},
				uniqueness: true

	validates_format_of :email,  :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
						:presence => "Ange en korrekt e-postadress."

end
