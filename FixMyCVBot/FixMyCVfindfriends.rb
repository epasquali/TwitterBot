#Finds all the friends (people user follows) of a given user

require 'twitterbot'

#The following is only for running on Windows, there seems to be some issue with SSL. 
#Remove this line when deploy on Heroku or elsewhere.
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

#Initialize/Open Twitter User account
client = TwitterBot.initialize
puts 'Initialized client: ' + client.user.screen_name
puts 'Located in: ' + client.user.location


usr = 'FixMyCVOnline'
friendsfile = File.open('FixMyCVFriends.txt', 'w')
friendcount = 0


friends = client.friends(usr, count:200)

puts 'Found the following friends for @' + usr + ':'

#spit out all friends
friends.each do |friend|
  puts friend.screen_name
  friendsfile.puts friend.screen_name
  friendcount += 1
end


puts 'Total friends found: ' + friendcount.to_s