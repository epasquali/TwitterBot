#Data miner based on search query and search options

require 'twitterbot'

#The following is only for running on Windows, there seems to be some issue with SSL. 
#Remove this line when deploy on Heroku or elsewhere.
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


#Initialize/Open Twitter User account
client = TwitterBot.initialize
puts 'Initialized client: ' + client.user.screen_name
puts 'Located in: ' + client.user.location


#Follow config:
#Number of follower adds/pushes we will do in this run
npushes = 3
#Follow a random number of users between 8 - 13 users. This is to fool the Twitter app
#spam police
nusers = rand(8..13)
#Rate limiting. Limit to nusers follow every nminutes minutes.
nminutes = 16
sleeptime = nminutes * 60

#Following from file:
fname = 'FollowBack.txt'
usrs = File.readlines(fname)

#Follow from file
npushes.times do |i|
    usrs.take(nusers).each do |usr|
       client.follow(usr)
       puts 'Following user: ' + usr
       #Now wait between 1-10 seconds to fool the twitter spam police
       sleep(rand(1..10))
    end
    puts 'Finished push '  + i.to_s + ' of ' + nusers.to_s + ' users'
    puts
    usrs.shift(nusers)
    nusers = rand(8..13)
    sleep(sleeptime)
end

#Clean up the file so we can use again in the future by removing who we already followed.
filew = File.open(fname, 'w')
filew.puts(usrs)


#User search criteria:
#followtags = ['#followback']
#soptions = {lang: "en"}

#followtags.each do |hashtag|
  #Follow from search
  #puts '*' * 160
  #puts 'FOLLOWING USERS WITH: ' + hashtag
  #puts '*' * 160
	#TwitterBot.follow(client, hashtag, soptions, nusers)
#end