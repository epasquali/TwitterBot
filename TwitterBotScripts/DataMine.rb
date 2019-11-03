#Data miner based on search query and search options

require 'twitterbot'

#The following is only for running on Windows, there seems to be some issue with SSL. 
#Remove this line when deploy on Heroku or elsewhere.
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


#Initialize/Open Twitter User account
client = TwitterBot.initialize
puts 'Initialized client: ' + client.user.screen_name
puts 'Located in: ' + client.user.location

#Geocodes
#geosearch = '46.95058,7.43675,100km' #Switzerland
geosearch = '37.7749295,-122.4194155,10km' #San Francisco
#geosearch = '40.8257625,-96.6851982,300km' #Lincoln, Nebraska
#Configure data miner
searchterms = ['#followback', '#autofollow', '#teamfollowback', '#ifollowback', 
	           '#followtrain', '#follow4follow', '#followforfollow', '#f4f',
	           '#followcircle']
#dmoptions = {lang: "en", geocode: geosearch}
dmoptions = {lang: "en"}
nresults = 2000

#Output file:
resultfile = File.open('FollowBack.txt', 'w')
tmpfile = File.open('tmpfile.txt', 'w+')


searchterms.each do |hashtag|
    puts '*' * 160
    puts 'DATA MINING'
    puts 'Search terms: ' + hashtag
    TwitterBot.findtweets(client, hashtag, dmoptions, nresults).each do |tweet|
	   puts '@' + tweet.user.screen_name + ': ' + tweet.text
	   puts
	   tmpfile.puts tweet.user.screen_name
   end
end

#Remove duplicates and cleanup
tmpfile.close
lines = File.readlines(tmpfile).uniq
resultfile.puts(lines)
puts 'Data Mining found ' + lines.size.to_s + ' unique results.'
File.delete(tmpfile)