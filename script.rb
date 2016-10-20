require 'rest-client'
require 'json'

def get_token
	params = {
		grant_type: 'password',
		username: '', # Put your bot's username as a string here
		password: '' # And your bot's password here
	}
	headers = {'User-Agent': "!!!!REPLACE ME!!!!", :accept => :json, content_type: :json}

	response = RestClient::Request.execute(
		method: :post,
		url: 'https://www.reddit.com/api/v1/access_token',
		user: '', #Your app's client_id goes here as a string
		password: '', #Your app's secret code goes here
		payload: params,
		headers: headers
		)

	data_hash = JSON.parse(response)

	data_hash['access_token']
end

# Returns a data hash of r/subreddit/comments.
def comment_stream(subreddit)

	headers = { 'Authorization': "bearer #{get_token}",
							'User-Agent': "!!!!REPLACE ME!!!!", 
							:accept => :json, content_type: :json}
	
	response = RestClient::Request.execute(
		method: :get,
		url: "https://oauth.reddit.com/r/#{subreddit}/comments?limit=100",
		headers: headers)

	data_hash = JSON.parse(response)
end

# Returns true if comment contains 'Thanks Obama' or 'Thanks, Obama'
# Case insensitive
def check_condition(comment)
	condition_1 = 'thanks obama'
	condition_2 = 'thanks, obama'
	text = comment['body'].downcase
	check_1 = text.scan(condition_1)
	check_2 = text.scan(condition_2)
	if check_1[0] === condition_1
		return true 
	elsif check_2[0] === condition_2
		return true
	end
	false
end

# Replies "You're welcome." to the provided comment_id
def reply(comment_id)

	params = {
		api_type: 'json',
		text: "You're welcome.",
		thing_id: comment_id
	}

	headers = { 'Authorization': "bearer #{get_token}",
							'User-Agent': "!!!!REPLACE ME!!!!"}

	response = RestClient::Request.execute(
		method: :post,
		url: 'https://oauth.reddit.com/api/comment',
		payload: params,
		headers: headers)
end


# Returns link id of comment
def get_link_id(comment)
	return comment['name']
end

# Scans each comment in given subreddit and replies if it meets the criteria
# Subreddit must be given as string
def comment_stream_scan(subreddit)
	my_hash = comment_stream(subreddit)
	comments = my_hash['data']['children']
	replies = 0
	comments.each do |x|
		comment = x['data']
		# If any comment meets the condition
		if check_condition(comment)
			# We get the id of the comment
			link_id = get_link_id(comment) 
			# and reply
			reply(link_id)
			replies += 1
			puts "Replied"
			exit
		end
	end
	if replies === 0
		puts "Sorry, no one thanked Obama"
	end
	puts 'This scan is done'
	replies = 0
end


# Just run ruby script.rb on the command line
comment_stream_scan('all')