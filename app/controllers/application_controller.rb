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

  def remote_hostname
	  require 'resolv'
	  Resolv.getname(request.remote_ip)
	end

  def add_headers
  	ALLOWED_HOSTS.each do |allowed_host|
  		allowed_host_uri = URI(allowed_host)
  		request_uri = URI(request.env["REQUEST_URI"])
  		if uris_match?(allowed_host_uri, request_uri)
  			response.headers["Access-Control-Allow-Origin"] = host_from_uri(allowed_host_uri)
  			break
  		end
  	end
	end


	def host_from_uri(uri)
		"#{uri.scheme}://#{uri.host}:#{uri.port}"
	end

	def uris_match?(a, b)
		a.scheme == b.scheme && a.host == b.host && a.port == b.port
	end

end
