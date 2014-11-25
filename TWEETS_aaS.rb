#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'

#
# this is the script for the twitter bot TWEETS_aaS
# generated on 2014-11-24 16:23:24 -0800
#

consumer_key 'YvehPW9QhuF0mrP2T0OpvQxqP'
consumer_secret 'GM6DKY6X2qTQm0K3oWGYsz7tRPiCRyrdDhP87X7k0YpOIRsbiT'

secret 'ECu3uP6dd3HobPyitbyDQ49GmPYSqP38s61SHzIMB3gEO'
token '2909447275-SuZ8ya78XrtLWcpNgalRJmvGoRUln7J9Qzw6PgE'

# remove this to send out tweets
debug_mode

# remove this to update the db
no_update
# remove this to get less output when running
verbose

# here's a list of users to ignore
blacklist "abc", "def"

# here's a list of things to exclude from searches
exclude "hi", "spammer", "junk"

search "keyword" do |tweet|
 reply "Hey #USER# nice to meet you!", tweet
end

replies do |tweet|
  reply "Yes #USER#, you are very kind to say that!", tweet
end
