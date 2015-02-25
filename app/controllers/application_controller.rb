class ApplicationController < ActionController::Base

	ALLOWED_HOSTS = [
		'http://localhost:3000',
		'http://localhost:9000',
		'https://dcf-frontend.herokuapp.com'
	]


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :add_headers


  private


  # Adds the Access-Control-Allow-Origin header to allow access from anywhere.
  # If a list of allowed origins is required, then the client must send an Origin header,
  # and the server compares it with a whitelist, and returns a single uri as the allowed origin
  # if it is in that whitelist.
  #
  def add_headers
  	response.headers["Access-Control-Allow-Origin"] = '*'
	end



end
