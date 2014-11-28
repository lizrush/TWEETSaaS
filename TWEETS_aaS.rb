require 'twitter'
require 'yaml'

class TaaS

  def initialize(config_file, services, posted_services)
    @client    = create_twitter_client(YAML.load_file(config_file))
    @services  = File.read(services).split("\n")
    @tweet_log = posted_services
    @posted_services = File.read(posted_services).split("\n")
  end

  def pick_service
    service = @services.sample
    check_if_already_posted(service) ? pick_service : service
  end

  def check_if_already_posted(service)
    @posted_services.include?(service)
  end

  def create_new_tweet
    @service = pick_service
    @tweet = "#{create_acronym(@service)}aaS: #{@service} as a Service"
  end

  def and_go!
    create_new_tweet
    @client.update("#{@tweet}")
    update_posted_services
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

  def create_acronym(service)
    words   = service.split
    acronym = ""
    words.each do |word|
      acronym += word[0].upcase
    end
    acronym
  end

  def update_posted_services
    open(@tweet_log, 'a+') { |f|
      f.puts "#{@service}"
    }
  end
end
