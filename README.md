This is a call and response reddit bot created in ruby using [Rest Client](https://github.com/rest-client/rest-client).

This particular bot was designed to check the newest 100 comments for the phrase 'Thanks, Obama'. If the phrase is found the bot replies 'You're welcome' to that comment.

You can clone this repo and use the bot as is by filling in the missing credentials or use it as a template to create a more robust and complex bot... or just a more original bot.

To use reddit's API you must first register your app [here](https://www.reddit.com/prefs/apps) under an account you've created for your bot. Give the app a name, a description and select script. About url can be left blank but the redirect uri can't be left blank. The redirect uri won't matter for this script so anything can go there but it can't be left blank.

Once the app is registered with Reddit you can find your app's client_id under the phrase 'personal use script' and your app's secret code will be next to the word 'secret'. 

That will give you everything you need to use this bot as is. If, however; you wish to use this repo as a jumping off point then make sure to follow Reddit's API rules [here](https://github.com/reddit/reddit/wiki/API) and [here](https://www.reddit.com/dev/api) is where the API methods can be found. 
