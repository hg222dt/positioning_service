module Api
	class EndUsersController < ApplicationController
		
		respond_to :json, :xml

		before_action :offset_params


		def getUserDoodles

			@doodles = Doodle.where("poster_user_id = ?", params[:end_user_id]).order(:created_at).all.limit(@limit).offset(@offset);
		
			respond_with :api, @doodles

		end

		def create
			@end_user = EndUser.new(end_user_params);

			if @end_user.save
		    respond_with :api, @end_user
			else
				#Skicka tillbaka felmeddelande?
				
			end

		end

		def index
			@users = EndUser.all
			respond_with :api, @users
		end

		private

		def end_user_params
	    params.require(:end_user).permit(:username, :email, :password, :password_confirmation, :bio_text)
	  end


	end
end