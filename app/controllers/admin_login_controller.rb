class AdminLoginController < ApplicationController
  
  def admin_revoke_key
    @user = User.find(params[:user])
    @user.authkey = nil;
    @user.admin_revoked_key = true;
    @user.save
    redirect_to admin_page_path
  end


end
