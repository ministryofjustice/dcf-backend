class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :add_headers


  private

  def add_headers
	  response.headers["Access-Control-Allow-Origin"] = "http://localhost:9000"
	end
end
