class ApikeysController < ApplicationController

	before_action :require_login

	def show
		@user = User.find(session[:userid])
	end

	def admin_page
    	@users = User.all
  	end

end
