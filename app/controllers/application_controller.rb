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

  def add_headers
  	# request_uri = URI(request.env["REQUEST_URI"])
  	# Rails.logger.info ">>>>>>>>>>>>>>>> DEBUG request uri is #{request_uri.to_s}    #{__FILE__}::#{__LINE__} <<<<<<<"

  	# ALLOWED_HOSTS.each do |allowed_host|
  	# 	allowed_host_uri = URI(allowed_host)
  	# 	Rails.logger.info ">>>>>>>>>>>>>>>> DEBUG checking allowed host #{allowed_host_uri}    #{__FILE__}::#{__LINE__} <<<<<<<"
  	# 	if uris_match?(allowed_host_uri, request_uri)
  	# 		Rails.logger.info ">>>>>>>>>>>>>>>> DEBUG MATCH    #{__FILE__}::#{__LINE__} <<<<<<<"
  	# 		response.headers["Access-Control-Allow-Origin"] = host_from_uri(allowed_host_uri)
  	# 		break
  	# 	end
  	# 	Rails.logger.info ">>>>>>>>>>>>>>>> DEBUG NO_MATCH - creating x header from #{request_uri.to_s}    #{__FILE__}::#{__LINE__} <<<<<<<"
  	# 	response.headers["X-Access-Control-Allow-Origin"] = host_from_uri(request_uri.to_s)
  	# end
  	response.headers["Access-Control-Allow-Origin"] = ALLOWED_HOSTS.join(' ')
	end


	# def host_from_uri(uri)
	# 	"#{uri.scheme}://#{uri.host}:#{uri.port}"
	# end

	# def uris_match?(a, b)
	# 	a.scheme == b.scheme && a.host == b.host && a.port == b.port
	# end

end
