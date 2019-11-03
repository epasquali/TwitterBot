#Finds all the followers of a given user

require 'twitterbot'

#The following is only for running on Windows, there seems to be some issue with SSL. 
#Remove this line when deploy on Heroku or elsewhere.
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

#Initialize/Open Twitter User account
client = TwitterBot.initialize
puts 'Initialized client: ' + client.user.screen_name
puts 'Located in: ' + client.user.location


usr = 'FixMyCVOnline'
followerfile = File.open('FixMyCVFollowers.txt', 'w')
followercount = 0

followers = client.followers(usr, count:200)

puts 'Found the following followers for @' + usr + ':'

#spit out all followers
followers.each do |follower|
  puts follower.screen_name
  followerfile.puts follower.screen_name
  followercount += 1
end


puts 'Total followers found: ' + followercount.to_s