module Api
	class TagsController < ApplicationController
		respond_to :json, :xml

		before_action :offset_params

		def index
			@tags = Tag.all.limit(@limit).offset(@offset)
			respond_with :api, @tags
		end

	end
end
