require 'twitter'
class Hashtag < ApplicationRecord


  def get_tweets

    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = "OncKq7qiS2nW9AeXjzNlNb94K"
      config.consumer_secret     = "hrTMRf6HdN5A9iZiYcTcit9MYQRU5sCRXXTfdKFUYC3GcD6ahP"
      config.access_token        = "513850114-6IrCKbo7XbJO6DPXVCn8RecJhM0ofiT8Fj9n722M"
      config.access_token_secret = "474FxENay4cRPjI4ChBWUXMBn6S8CTPSHkmdJV0EkYHqp"
    end
    byebug
    topics = ["coffee", "tea"]
    client.filter(track: topics.join(",")) do |object|
      puts object.text if object.is_a?(Twitter::Tweet)
    end


  end
end
