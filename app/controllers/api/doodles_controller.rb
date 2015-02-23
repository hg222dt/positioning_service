module Api
	class DoodlesController < ApplicationController
		respond_to :json, :xml

	  def index
	  	@doodles = Doodle.all
	    respond_with @doodles
	  end

	  def create
	  	@doodle = Doodle.new(doodle_post_params)    # using strong parameters
	  	@doodle.save
	  	# respond_with @doodle
	  	respond_with :api, @doodle
	  end

	  def show
	  	@doodle = Doodle.find(params[:id]);
	  	respond_with @doodle
	  end
	  

	  private

	  def doodle_post_params
			params.require(:doodle).permit(:doodle_text)
	  end

	end
end