Rails.application.config.middleware.use OmniAuth::Builder do
  api_key = Rails.application.secrets.twitter_consumer_key
  shared_secret = Rails.application.secrets.twitter_consumer_secret_key

  provider :twitter, api_key, shared_secret
end