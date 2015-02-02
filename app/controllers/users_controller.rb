class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

  	@apiKey = 1111

  	@user.authkey = @apiKey


  	if @user.save
  		#redirect_to users_path
      render :action => "user_page"
  	else
  		render :action => "new"
  	end
  end

  private

  def user_params
    params.require(:user).permit(:email, :webbsite_url, :website_name)
  end

  def user_page
    @user = User.new(user_params);

  end

end
