To create your own Twitter Account Bot:

1. Copy TwitterBotScripts to your own directory, rename with the name of your account bot (i.e. FixMyCVBot).

2. Populate the pics folder with images suitable to your account. These are images that will be randomly
combined with your tweets to form image tweets.

3. Create a twitter app, set environment variables to use them, and modify the scripts in this folder to suit your
particular account.


The following scripts are written individually so they can be scheduled to run individually with cron, crontask, 
or similar.

Functions performed by the scripts include:
1. Periodically tweet normal advert deck to followers
2. Reply to specific users who used particular hashtag (might want to invent a new hashtag)
3. Retweet tweets with interesting hashtags or other search criteria.
4. Follow interesting users (by hashtag, location, or search term)
5. Cull following list by cutting out unfollowers.

BONUS FUNCTION:
6. Data miner. 


