module Api
	class DoodlesController < ApplicationController
		respond_to :json, :xml

		before_action :checkApiKey
		before_action :offset_params
		before_action :coordinates_params


	  def index

	  	query_term_params

	  	if @query

	  		@doodle = Doodle.where("doodle_text LIKE ?", "%#{@query}%") 
	  		respond_with :api, @doodle

	  	elsif params[:lat].present? and params[:long].present? and params[:range].present?
	  		
		  	@location_origin = Location.new
		  	@location_origin.lat = @lat
		  	@location_origin.lng = @long
		  	@locations = Location.within(@range, :origin => @location_origin).order(:created_at).all.limit(@limit).offset(@offset);

		  	@doodles = []

		  	@locations.each do |loc|
		  		@doodles << Doodle.where("location_id = ?", loc.id)
				end

				respond_with :api, @doodles
			else
		  	@doodles = Doodle.all.limit(@limit).offset(@offset).order(created_at: :desc)
		    respond_with :api, @doodles
		  end
	  end

	  def create

	  	if end_user_authenticate

		  	@tag = Tag.where("name = ?", params[:tag_name]).first

		  	if @tag == nil
		  		@tag = Tag.new(name: params[:tag_name])
		  	end
		  		
		  	@doodle = Doodle.new
		  	@doodle.doodle_text = params[:doodle_text]
		  	@doodle.end_user_id = params[:end_user_id]
		  	@doodle.tag = @tag
		  	@doodle.location = Location.new(lat: params[:lat], lng: params[:long])
		  	@doodle.save

		  	# @doodleLocation = Doodle.joins(:location).last

		  	respond_with :api, @doodle

		  end

	  end

	  def show
		  @doodle = Doodle.find(params[:id])
	  	respond_with :api, @doodle
	  end

	  def getAllLocations
	  	@locations = Location.all
	  	respond_with :api, @locations
	  end


	  def update
	  	if end_user_authenticate

	  			@doodle = Doodle.find(params[:id])

	  			@user_id_doodle = @doodle.end_user_id

	  			if @token_payload[0]["user_id"] == @user_id_doodle

			  		@doodle = Doodle.update(params[:id], doodle_text: params[:doodle_text])
		  			render json: { message: 'Object successfully updated' }, status: :ok 
		  		else
		  			render json: { message: 'Not authorized' }, status: :forbidden
		  		end
			end

			rescue => error
				render json: { message: 'Object not found'}, status: :bad_request 

	  end


	  def destroy
	  	if end_user_authenticate

	  			@doodle = Doodle.find(params[:id])

	  			@user_id_doodle = @doodle.end_user_id

	  			if @token_payload[0]["user_id"] == @user_id_doodle
			  		Doodle.destroy(params[:id])
			  		render json: { message: 'Object seccessfully removed' }, status: :ok			  	
			  	else
			  		render json: { message: 'Not authorized' }, status: :forbidden
			  	end
	  	end

  		rescue => error
				render json: { message: 'Object not found'}, status: :bad_request 
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