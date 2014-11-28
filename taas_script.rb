#!/usr/bin/env ruby

require_relative 'TWEETS_aaS.rb'

taas = TaaS.new('TaaSconfig.yml', 'services.txt', 'posted_services.txt')

taas.and_go!
