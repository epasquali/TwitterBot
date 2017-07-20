#General twitter bot utilities
module TwitterBot

require 'twitter'

	def self.initialize
	    #Initializes the Twitter API and other TwitterBot variables.
	    #Initialize from environment variables. In Windows, use SET to set them prior.
        client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['consumer_key']
        config.consumer_secret = ENV['consumer_secret']
        config.access_token = ENV['access_token']
        config.access_token_secret = ENV['access_token_secret']
        end
	end

	def self.findtweets(client, searchterm, options, count)
   	   tweets = client.search(searchterm, options).take(count)
    end

    def self.rndmsg(client, msgs)
    	#Tweets a random message from the msgs deck
    	msg = msgs.sample
    	#Tweet!
    	client.update(msg)
    	puts 'Tweeted message: ' + msg
    end

	def self.rndimagemsg(client, msgs, imgdir)
		#Tweets a random combination of messages plus image. Imgdir must contain
		#ending slash i.e. C:/User/pics/
		#Get the array of image names. Drop the first two elements cuz they're just dots
		images = Dir.entries(imgdir).drop(2)
		msg = msgs.sample
		image = images.sample
		#Tweet!
		client.update_with_media(msg, File.new(imgdir + image))
		puts 'Tweeted message: ' + msg
		puts 'With image: ' + image
	end

	def self.textreply(client, searchterm, options, msgs, count)
		#Reply to hashtag with random message.
        self.findtweets(client, searchterm, options, count).each do |tweet|
            puts '@' + tweet.user.screen_name + ': '+ tweet.text
            msg = msgs.sample
            #Twitter replies do not work with the @usrmention
            usrmention = '@'+ tweet.user.screen_name + ' '
            client.update(usrmention + msg, in_reply_to_status_id:tweet.id)
            puts 'Replied with msg: ' + msg
        end
	end


	def self.imgreply(client, searchterm, options, msgs, imgdir, count)
		#Reply to hashtag with random image/msg combination
		images = Dir.entries(imgdir).drop(2)

        self.findtweets(client, searchterm, options, count).each do |tweet|
			puts '@' + tweet.user.screen_name + ': '+ tweet.text
			msg = msgs.sample
			image = images.sample
			#Dont' forget the @usrmention otherwise it doesn't work as reply.
			usrmention = '@'+ tweet.user.screen_name + ' '
			client.update_with_media(usrmention + msg, File.new(imgdir + image), 
				                     in_reply_to_status_id:tweet.id)
			puts 'Replied with msg: ' + msg
			puts 'And image: ' + image
		end
	end

   def self.retweet(client, searchterm, options, count)
   	   #Retweets tweets with a certain searchterm
   	   self.findtweets(client, searchterm, options, count).each do |tweet|
   	   	   client.retweet(tweet)
   	   	   puts 'Retweeted: ' + tweet.user.screen_name
   	   	   puts 'With message: ' + tweet.text 
   	   	   puts
   	   	end
   end

   def self.follow(client, searchterm, options, count)
   	   #Automatically follows users who match the search term
   	   self.findtweets(client, searchterm, options, count).each do |tweet|
   	   	  unless client.user.screen_name == tweet.user.screen_name
   	   	      #Don't follow yourself! 
   	   	   	  client.follow(tweet.user.screen_name)
   	   	      puts 'Following user: ' + tweet.user.screen_name
   	   	      puts 'Who tweeted: ' + tweet.text
   	   	      #Watch the rate limit, sleep 2 minutes
   	   	      sleep(2*60) 
   	   	  end
   	   end
   	end

   	def self.cull(client, count)
   		#Culls / Unfollows users who are not "friends" (who follow you back)
   		friendslist = client.friends(client.user.screen_name, count:200)
   		followerlist = client.followers(client.user.screen_name, count:200)

        #Filter out the screennames:
        friends = friendslist.map{|name| name.screen_name}
        followers = followerlist.map{|name| name.screen_name }

   		#The set of names not common to both sets
   		culllist = (friends - followers) | (followers - friends)
   		
   		#delete count elements from culllist at random.
   		culllist.sample(count).each do |meanie|
   			puts 'Unfollowing: @' + meanie
   			client.unfollow(meanie)
   			#For the spambot, sleep random number of seconds
   			sleep(rand(1..10))
   		end
   	end


end