class EndUser < ActiveRecord::Base

	has_many :doodles

	include Rails.application.routes.url_helpers 

	has_secure_password


	validates 	:email,
				:presence => {:message => "Du måste ange en e-postadress."},
				uniqueness: true

	validates_format_of :email,  :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
						:presence => "Ange en korrekt e-postadress."
	
	def serializable_hash (options={})
    options = {
    	only: [:id, :email, :username],
      methods: [:self_link]
    }.update(options)
    super(options)
  end

	def self_link
    { :self => "#{Rails.configuration.baseurl}#{api_show_end_user_path(self)}.json" }
  end
end