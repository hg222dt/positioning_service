module Api
	class DoodlesController < ApplicationController
		respond_to :json, :xml

		before_action :offset_params

	  def index
	  	@doodles = Doodle.all.limit(@limit).offset(@offset)
	    respond_with :api, @doodles
	  end

	  def create
	  	@doodle = Doodle.new
	  	@doodle.doodle_text = params[:doodle_text]
	  	@doodle.end_user_id = params[:end_user_id]

	  	@location = Location.new
	  	@location.latitude = params[:lat]
	  	@location.longitude = params[:long]
	  	@location.save

	  	@doodle.location_id = @location.id

	  	@doodle.save
	  	respond_with :api, @doodle
	  end

	  def show
	  	coordinates_params

	  	@doodle = Doodle.find(params[:id]);
	  	respond_with :api, @doodle

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