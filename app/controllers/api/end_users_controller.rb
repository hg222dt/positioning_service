module Api
	class EndUsersController < ApplicationController
		
		respond_to :json, :xml

		before_action :offset_params 
		before_action :checkApiKey

		def getUsersDoodles

			@doodles = Doodle.where("end_user_id = ?", params[:end_user_id]).order(:created_at).all.limit(@limit).offset(@offset)

			respond_with :api, @doodles

		end

		def create

			@end_user = EndUser.new(end_user_params)


			if @end_user.save
		    render json: {message: @end_user }, status: :created
			else
				render json: {error: "Internal Error. User could not be added to database"}, status: 500
			end
		end

		def index
			@users = EndUser.all
			respond_with :api, @users
		end


		def api_auth
     
	    end_user = EndUser.find_by(email: params[:email].downcase)
	    if end_user && end_user.authenticate(params[:password])
	      
	      render json: { auth_token: encodeJWT(end_user) }
	    else
	      render json: { error: 'Invalid username or password' }, status: :unauthorized
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