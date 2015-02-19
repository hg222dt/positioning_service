class AdminLoginController < ApplicationController

  def index
  	u = User.find_by_email(params[:email])
    if u && u.is_user_admin && u.authenticate(params[:password])
      session[:userid] = u.id
      redirect_to admin_login_path
    else
      flash[:notice] = "Inloggningen misslyckades."
      redirect_to root_path
    end
  end
  
end
