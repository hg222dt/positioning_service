class AdminLoginController < ApplicationController

  def index
  	u = User.find_by_email(params[:email])
    if u && u.is_user_admin && u.authenticate(params[:password])
      session[:userid] = u.id
      redirect_to admin_login_path
    else
      flash[:notice] = "Failed"
      redirect_to root_path
    end
  end

  def admin_login
    if session[:userid] == nil
      redirect_to root_path
    end

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


end
