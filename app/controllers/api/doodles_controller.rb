module Api
	class DoodlesController < ApplicationController
		respond_to :json, :xml

		before_action :offset_params
		before_action :coordinates_params

	  def index

	  	if params[:lat].present? and params[:long].present? and params[:range].present?
	  		
		  	@location_origin = Location.new
		  	@location_origin.lat = @lat
		  	@location_origin.lng = @long
		  	@locations = Location.within(@range, :origin => @location_origin)

		  	@doodles = []

		  	@locations.each do |loc|
		  		@doodles << Doodle.where("location_id = ?", loc.id)
				end

				respond_with :api, @doodles
			else
		  	@doodles = Doodle.all.limit(@limit).offset(@offset)
		    respond_with :api, @doodles
		  end
	  end

	  def create
	  	@doodle = Doodle.new
	  	@doodle.doodle_text = params[:doodle_text]
	  	@doodle.end_user_id = params[:end_user_id]

	  	@location = Location.new
	  	@location.lat = params[:lat]
	  	@location.lng = params[:long]
	  	@location.doodle_id = 14
	  	@location.save

	  	
	  	@doodle.save
	  	respond_with :api, @doodle
	  end

	  def show

	  	@doodle = Doodle.find(params[:id]);
	  	respond_with :api, @doodle

	  end

	  def getAllLocations
	  	@locations = Location.all
	  	respond_with :api, @locations
	  end
	  

	  private

	  # def doodle_post_params
			# params.require(:doodle).permit(:doodle_text, :poster_user_id)
	  # end

	  # def get_posted_coordinates
	  # 	params.require(:doodle).permit(:lat, :long)
	  # end

	end
end