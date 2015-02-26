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




  LAT = 123
  LONG = 123
  RANGE = 500

  def coordinates_params
    if params[:lat].present?
      @lat = params[:lat].to_f
    end
    if params[:long].present?
      @long = params[:long].to_f
    end
    if params[:range].present?
      @range = params[:range].to_i
    end
    @lat ||= LAT
    @long  ||= LONG
    @range ||= RANGE
  end


  def query_term_params
    if params[:q].present?
      @query = params[:q].to_str
    else
      @query = nil
    end
  end


  def current_user
  	@current_user ||= User.find(session[:userid]) if session[:userid]
  end

  def require_login
  	if current_user.nil? then
  		redirect_to root_path
  	end
  end


  def checkApiKey
    if request.headers["apikey"].present?

      api_key_header = request.headers['apikey'].split(' ').last

      api_key = api_key_header.strip

      authenticateApiKey(api_key)

    else
      render json: { error: 'Need to include the API key in header' }, status: :forbidden
    end

  end

  def authenticateApiKey(a)
    # Kolla av mot ditt user-register att api-nyckeln finns tillgänglig
    # registrera ev inloggninen
    @apiUsers = User.all

    @apiKeyFound = false

    @apiUser

    @apiUsers.each do |apiUser|
      if apiUser.authkey == a
        @apiKeyFound = true
        @apiUser = apiUser
        ApiUserStat.new(user: @apiUser)
      end
    end

    if @apiKeyFound == true
      true
    else
      render json: { error: 'ApiKey is not correct' }, status: :bad_request
    end
  end
end
