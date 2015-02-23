class DoodlesController < ApplicationController
	respond_to :json, :xml

  def index
  	@doodle = Doodle.all
    respond_with @doodle
  end

  def create
  	@doodle = Doodle.new(doodle_params)    # using strong parameters
  	@doodle.save
  	respond_with @doodle
  end

  

  private

  def doodle_params
		params.require(:doodle).permit(:doodle_text)
  end
end
