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


  def checkUserAuth


  end

  # authenticates users for unsafe methods
  def end_user_authenticate 
    if request.headers["Authorization"].present?

      # stripping down and decoding incoming authtoken
      auth_header = request.headers['Authorization'].split(' ').last
      @token_payload = decodeJWT auth_header.strip

      if !@token_payload
        render json: { error: 'The provided user auth token wasn´t correct' }, status: :bad_request 
        false
      else
        # puts @token_payload[0]["user_id"]
        true
      end
    else
      render json: { error: 'Need to include the Authorization header for user auth token' }, status: :unauthorized # The header isn´t present
      false
    end
  end

    # When we get a call we have to decode it - Returns the payload if good otherwise false
  def decodeJWT(authToken)
    # returns the token
    payload = JWT.decode(authToken, Rails.application.secrets.secret_key_base, "HS512")
    # returns the payload
    if payload[0]["exp"] >= Time.now.to_i
      payload
    else

      #token expired
      # fundera över om du ska ha någon rturn för att säga att token har gått ut. Ev länk för att generera ny.
      false
    end
    # if tiken is wrong
    rescue => error
      nil
  end

  # This method is for encoding the JWT before sending it out
  def encodeJWT(user, exp=2.hours.from_now)
    # adding expires parameter to authtokens payload
    payload = { user_id: user.id }
    payload[:exp] = exp.to_i
    
    # Encode the payload whit the application secret, and a more advanced hash method (creates header with JWT gem)
    JWT.encode( payload, Rails.application.secrets.secret_key_base, "HS512")
    
  end

end
