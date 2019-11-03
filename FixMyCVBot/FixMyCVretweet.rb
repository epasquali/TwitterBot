#Retweets based on search and search options

require 'twitterbot'

#The following is only for running on Windows, there seems to be some issue with SSL. 
#Remove this line when deploy on Heroku or elsewhere.
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


#Initialize/Open Twitter User account
client = TwitterBot.initialize
puts 'Initialized client: ' + client.user.screen_name
puts 'Located in: ' + client.user.location

#Retweet selection parameters
retweettags = ['#hiring']
rtoptions = {lang:"en"}
nretweets = 2

#Retweet deck: Retweets of key hashtags
retweettags.each do |hashtag|
	puts '*' * 160
	puts 'RETWEETING'
	puts 'Search term: ' + hashtag
	puts '*' * 160
    TwitterBot.retweet(client, hashtag, rtoptions, nretweets)
end