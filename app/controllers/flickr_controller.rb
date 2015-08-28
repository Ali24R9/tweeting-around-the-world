class FlickrController < ApplicationController
  require 'flickraw'
  FlickRaw.api_key = Rails.application.secrets.flickr_key
  FlickRaw.shared_secret = Rails.application.secrets.flickr_secret_key

  def get_token
#     token = flickr.get_request_token
#     auth_url = flickr.get_authorize_url(token['oauth_token'], :perms => 'delete')

# binding.pry
#     # begin
#     #   flickr.get_access_token(token['oauth_token'], token['oauth_token_secret'], verify)
#     #   login = flickr.test.login
#     #   puts "You are now authenticated as #{login.username} with token #{flickr.access_token} and secret #{flickr.access_secret}"
#     # rescue FlickRaw::FailedResponse => e
#     #   puts "Authentication failed : #{e.msg}"
#     # end

  end

end