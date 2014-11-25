require 'twitter'
require 'yaml'

class TaaS

  def initialize(config_file, services, tweet)
    @client    = create_twitter_client(YAML.load_file(config_file))
    @services  = File.read(services).split("\n")
  end

  def pick_service
    @services.sample
  end

  def check_if_already_posted(service)
    posted_services = File.read(posted_services).strip

    if posted_services.includes?(service)
      pick_service
    else
      service
    end
  end

  def create_new_tweet
    @service = pick_service
    check_if_already_posted(@service)
    @tweet = "#{@service} as a Service"
  end

  # need to figure out the param in here, what do i need to make this go
  def and_go!(secondlist, last_thought, target)
    if wakey_wakey
      create_new_tweet
      @client.update("#{@tweet}")
      update_posted_services(@tweet)
    end
  end

  # TaaS will not tweet if it is between midnight and 8 am on her remote server
  def wakey_wakey
    Time.now.strftime('%k').to_i <= 8 || Time.now.strftime('%k').to_i >= 16
  end

  private

  def create_twitter_client(config_hash)
    Twitter::REST::Client.new do |config|
      config.consumer_key        = config_hash['consumer_key']
      config.consumer_secret     = config_hash['consumer_secret']
      config.access_token        = config_hash['access_token']
      config.access_token_secret = config_hash['access_token_secret']
    end
  end

  #updates the last tweet
  def update_posted_services(tweet)
    open(posted_services, 'r+') { |f|
      f.puts "#{@tweet}"
    }
  end
end
