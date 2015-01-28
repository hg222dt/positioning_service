class RegisterController < ApplicationController
  def index
  	@register =  Register.all
  end
end
