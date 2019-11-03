#Tweets a random image tweet from a tweet message file and image directory.
#Assumes image directory is in /pics subdirectory of the same directory as this script.

require 'twitterbot'

#The following is only for running on Windows, there seems to be some issue with SSL. 
#Remove this line when deploy on Heroku or elsewhere.
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


#Initialize/Open Twitter User account
client = TwitterBot.initialize
puts 'Initialized client: ' + client.user.screen_name
puts 'Located in: ' + client.user.location

#Get the array of tweets
tweets = File.readlines('tweets.txt')

#Get the images directory
imgdir = Dir.pwd + '/pics/'

#Tweet!
TwitterBot.rndimagemsg(client, tweets, imgdir)