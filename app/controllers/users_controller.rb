class UsersController < ApplicationController
  def index
  	@user = User.new



  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

  	@apiKey = 1111

  	@user.authkey = @apiKey


  	if @user.save
      session[:userid] = @user.id;
      redirect_to apikey_path
  	else
  		render :action => "new"
  	end
  end

  private

  def user_params
    params.require(:user).permit(:email, :webbsite_url, :website_name, :password, :password_confirmation)
  end


end
