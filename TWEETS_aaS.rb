require 'twitter'
require 'yaml'

class TaaS

  def initialize(config_file, services, posted_services)
    @client    = create_twitter_client(YAML.load_file(config_file))
    @services  = File.read(services).split("\n")
    @posted_services = posted_services
  end

  # check services & posted services to see if I need to tweet at self to ask for more topics

  def pick_service
    @services.sample
  end

  def check_if_already_posted(service)
    posted_services = File.read(@posted_services).split("\n")

    if posted_services.include?(service)
      pick_service
    else
      service
    end
  end

  def create_new_tweet
    @service = pick_service
    check_if_already_posted(@service)
    @tweet = "#{create_acronym(@service)}: #{@service} as a Service"
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
    open(@posted_services, 'a+') { |f|
      f.puts "#{@service}"
    }
  end
end
