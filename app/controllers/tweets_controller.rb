class TweetsController < ApplicationController
  def get_tweets

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      # config.access_token        = Rails.application.secrets.twitter_access_token
      # config.access_token_secret = Rails.application.secrets.twitter_access_token
    end
    coordinates = JSON.parse(params[:coordinates])
    coordinates = {lat: coordinates["G"], lng: coordinates["K"]}
    results = client.geo_search(lat: coordinates[:lat], long: coordinates[:lng])

    place_id = results.attrs[:result][:places][0][:contained_within][0][:id]
    place_name = results.attrs[:result][:places][0][:contained_within][0][:name]

    place_name = place_name.gsub(/\s+/, "")
    tweets = client.search("##{place_name}", {place: place_id, lang: "en", result_type: "popular"})
    tweet_ids = []
    tweets_texts = []
    tweets.attrs[:statuses].each do |tweet|
      tweet_ids << tweet[:id]
    end
    embedded_tweets = []
    tweet_ids.each do |id|
      embedded_tweets << client.oembed(id)
    end
    render json: {embedded_tweets: embedded_tweets}
    # tweets_texts = []
    # tweets.attrs[:statuses].each do |tweet|
    #   tweets_texts << tweet[:text]
    # end

    # render json: {tweets_texts: tweets_texts}
  rescue Twitter::Error
    redirect_to root_path
    # binding.pry
  end

  # def create
  #   current_user.tweet(twitter_params[:message])
  # end

  # def twitter_params
  #   params.require(:tweet).permit(:message)
  # end
end
