module Api
	class TagsController < ApplicationController
		respond_to :json, :xml

		before_action :offset_params
		before_action :checkApiKey

		def index
			@tags = Tag.all.limit(@limit).offset(@offset)
			respond_with :api, @tags
		end
	end
end
