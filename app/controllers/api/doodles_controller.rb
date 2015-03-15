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
			  		
			  	@location = Location.new(lat: params[:lat], lng: params[:long])
			  	@location.save

			  	@doodle = Doodle.new
			  	@doodle.doodle_text = params[:doodle_text]
			  	@doodle.end_user_id = @token_payload[0]["user_id"]
			  	@doodle.tag = @tag
			  	@doodle.location = @location
			  	@doodle.save

			  	respond_with :api, @doodle
		  end

	  end

	  def show
		  @doodle = Doodle.where("doodles.id = ?", params[:id])
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

	  			# Checking if doodles user-id is corresponding requesting users jwt
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

	  			# Checking if doodles user-id is corresponding requesting users jwt
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
	  


	  # Getting doodles by tag name
	  def doodles_by_tag

	  	@tag = Tag.where("name = ?", params[:tag_name]).first

	  	@doodles = Doodle.joins(:tag).where(:tags => {:name => @tag.name})


			# render json: { message: @doodles}, status: :ok 	  
			respond_with :api, @doodles	

			rescue
	      @error = ErrorMessage.new("Could not find that resource. Are you using the right resource identification", "The requested item was not found!" )
	      respond_with  @error, status: :not_found
	  end

	end

	# Createing error message
	class ErrorMessage
	  
	  def initialize(message_developer, message_user)
	    @messageDeveloper = message_developer
	    @messageUser = message_user
	  end
	  
	  def to_xml(options={})
	    str = "<error>"
	    str += "  <developerMessage>#{@messageDeveloper}</developerMessage>"
	    str += "  <userMessage>#{@messageUser}</userMessage>"
	    str += "</error>"
	  end
	end

end