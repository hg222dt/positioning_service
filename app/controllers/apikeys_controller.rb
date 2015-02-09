class ApikeysController < ApplicationController

	before_action :require_login

	def show
		@user = User.find(session[:userid])
	end

end
