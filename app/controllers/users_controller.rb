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

    @user.is_user_admin = true;
  	@user.authkey = @apiKey


  	if @user.save
      session[:userid] = @user.id;
      redirect_to apikey_path
  	else
  		render :action => "new"
  	end
  end

  def delete

    User.find(session[:userid]).destroy

  end

  #Inloggningsmetoder
  def login
    u = User.find_by_email(params[:email])
    if u && !u.is_user_admin && u.authenticate(params[:password])
      session[:userid] = u.id
      redirect_to apikey_path
    else
      flash[:notice] = "Failed"
      redirect_to root_path
    end
  end

  def admin_login_page
    @user = User.new
  end


  def admin_login
    u = User.find_by_email(params[:email])
    if u && u.is_user_admin && u.authenticate(params[:password])
      session[:userid] = u.id
      redirect_to admin_page_path
    else
      flash[:notice] = "Failed"
      redirect_to root_path
    end
  end

  def admin_page
    @users = User.all
  end


  def logout
    session[:userid] = nil
    redirect_to root_path, :notice => "logged out"
  end

  def revoke_key

    delete()

    redirect_to logout_path
  end


  private

  def user_params
    params.require(:user).permit(:email, :webbsite_url, :website_name, :password, :password_confirmation)
  end


end
