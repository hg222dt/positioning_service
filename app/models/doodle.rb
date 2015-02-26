class Doodle < ActiveRecord::Base

	include Rails.application.routes.url_helpers 

	belongs_to :location
	belongs_to :tag
	belongs_to :end_user

	def serializable_hash (options={})
    options = {
    	include: [:tag, :location, :end_user],
      methods: [:self_link]
    }.update(options)
    super(options)
  end

	def self_link
    { :self => "#{Rails.configuration.baseurl}#{api_doodle_path(self)}.json" }
  end

end
