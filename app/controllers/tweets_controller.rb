class TweetsController < ApplicationController
  def get_tweets

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['_SECRET_TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['_SECRET_TWITTER_CONSUMER_SECRET_KEY']
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

  rescue Twitter::Error
    redirect_to root_path
  end

end
