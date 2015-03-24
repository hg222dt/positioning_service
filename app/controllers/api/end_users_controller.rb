module Api
	class EndUsersController < ApplicationController
		
		respond_to :json, :xml

		before_action :offset_params 
		before_action :checkApiKey

		# Getting a specific users doodles
		def getUsersDoodles

			@doodles = Doodle.where("end_user_id = ?", params[:end_user_id]).order(:created_at).all.limit(@limit).offset(@offset)

			respond_with :api, @doodles

		end

		# Getting a specific users doodles
		def getDoodlesByUsername

			@end_user = EndUser.where("username = ?", params[:end_user_username]).first;

			@doodles = Doodle.where("end_user_id = ?", @end_user.id).order(:created_at).all.limit(@limit).offset(@offset)

			respond_with :api, @doodles

		end

		def create

			@end_user = EndUser.new(end_user_params)

			@test_username = EndUser.where("username = ?", params[:end_user][:username]).first

			@test_email = EndUser.find_by(email: params[:end_user][:email])


			puts "loggning"
			puts params[:end_user][:email]
			puts params[:email]
			params[:username]
			# puts @test_username
			# puts @test_email
			puts "loggning"

			if @test_username

				render json: {error: "Username is allready taken", error_message_id: 1}, status: 400
			
			elsif @test_email
			
				render json: {error: "Email is allready taken", error_message_id: 2}, status: 400
			
			else

				if @end_user.save
			    render json: {message: @end_user }, status: :created
				else
					render json: {error: "Internal Error. User could not be added to database"}, status: 500
				end
			end

		end

		def index
			@users = EndUser.all
			respond_with :api, @users
		end


		def api_auth
     
	    end_user = EndUser.find_by(email: params[:email].downcase)
	    if end_user && end_user.authenticate(params[:password])
	      
	      render json: { auth_token: encodeJWT(end_user), end_user: end_user }

	      # @response = {:user => end_user, :token => encodeJWT(end_user)}

	      # respond_with :api, @response
	    else
	      render json: { error: 'Invalid username or password', user_message_id: 1 }, status: :unauthorized
	    end

	  end

		private

		def end_user_params
	    params.require(:end_user).permit(:username, :email, :password, :password_confirmation, :bio_text)
	  end

	  def show
	  	@user = EndUser.find(:id)
	  	respond_with :api, @user
	  end
	end
end