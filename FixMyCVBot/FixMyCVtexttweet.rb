#Tweets a random text tweet from a tweet message file

require 'twitterbot'

#The following is only for running on Windows, there seems to be some issue with SSL. 
#Remove this line when deploy on Heroku or elsewhere.
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


#Initialize/Open Twitter User account
client = TwitterBot.initialize
puts 'Initialized client: ' + client.user.screen_name
puts 'Located in: ' + client.user.location

#Get the array of tweets
tweets = File.readlines('perstweets.txt')
ntweets = 2
sleepinterval = 15*60 #15 minutes

#Tweet!
ntweets.times do
  TwitterBot.rndmsg(client, tweets)
  sleep(sleepinterval)
end
