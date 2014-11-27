require_relative 'TWEETS_aaS.rb'

taas = TaaS.new('TaaSconfig.rb', 'services.txt', 'posted_services.txt')

taas.and_go!
