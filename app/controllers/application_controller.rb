class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #protect_from_forgery with: :exception


  # default parameters, maby put i config-file?
  OFFSET = 0
  LIMIT = 20

  # check if user whants offset/limit
  def offset_params
    if params[:offset].present?
      @offset = params[:offset].to_i
    end
    if params[:limit].present?
      @limit = params[:limit].to_i
    end
    @offset ||= OFFSET
    @limit  ||= LIMIT
  end




  LAT = 0
  LONG = 0
  RANGE = 0

  def coordinates_params
    if params[:lat].present?
      @lat = params[:lat].to_i
    end
    if params[:long].present?
      @long = params[:long].to_i
    end
    if params[:range].present?
      @range = params[:range].to_i
    end
    @lat ||= LAT
    @long  ||= LONG
    @range ||= RANGE
  end



  def current_user
  	@current_user ||= User.find(session[:userid]) if session[:userid]
  end

  def require_login
  	if current_user.nil? then
  		redirect_to root_path
  	end
  end

end
