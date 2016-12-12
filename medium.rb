class Medium
	require 'json'
	require 'httparty'
	print "Enter your access token here: "
	@@token = gets.chomp
	def initialize()
		response = HTTParty.get("https://api.medium.com/v1/me", :headers => {"Authorization" => "Bearer " + @@token})
		@@user_id = JSON.parse(response.body)["data"]["id"]
	end

	def get_id
		puts @@user_id
	end

	def get_publications
		response = HTTParty.get("https://api.medium.com/v1/users/#{@@user_id}/publications", :headers => {"Authorization" => "Bearer " + @@token})
		puts JSON.pretty_generate(response)
	end

	def post
		@content = {"title" => "test",
					"contentFormat" => "html",
				    "content" => "<h1>Liverpool FC</h1><p>You’ll never walk alone.</p>",
				    "tags" => ["kachi"],
				    "publishStatus" => "unlisted"}.to_json
		options = {:body=>@content,:headers => {"Authorization" => "Bearer " + @@token, "Content-Type" =>"application/json", "Accept" => "application/json"}}
		HTTParty.post("https://api.medium.com/v1/users/#{@@user_id}/posts", options)
	end
end

kachi = Medium.new()
kachi.get_id
kachi.get_publications
kachi.post