#Replies a random image tweet based on search criteria. Assumes images are in
#/pics/ subdirectory of current directory.

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
#And the image directory
imgdir = Dir.pwd + '/pics/'

#Reply selection parameters
#replytags = File.readlines('replytohashtags.txt')
replytags = ['#hatemyjob']
nreplies = 25
replyoptions = {lang:"en"}

#Reply deck. Go through each hashtag and reply with message to each.
replytags.each do |hashtag|
	puts '*' * 160
	puts 'REPLYING to hashtag: ' + hashtag
	puts '*' * 160
	TwitterBot.imgreply(client, hashtag, replyoptions, tweets, imgdir, nreplies)
end