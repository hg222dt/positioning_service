class Doodle < ActiveRecord::Base
	belongs_to :location
	belongs_to :tag

end
