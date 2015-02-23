module Api
	class EndUsersController < ApplicationController
		
		respond_to :json, :xml

		before_action :offset_params


		def getUserDoodles

			@doodles = Doodle.where("poster_user_id = ?", params[:end_user_id]).order(:created_at).all.limit(@limit).offset(@offset);
		
			respond_with :api, @doodles

		end




	end
end