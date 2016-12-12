require 'httparty'
require 'json'
require 'launchy'

print "What do you want to search for: "
search_param = gets.chomp

url = "https://content.guardianapis.com/search?q=" + search_param
response = HTTParty.get(url, :headers => {"api-key" => "b532c9fc-9876-4c54-8eba-ecd2ab382367"})
# puts JSON.pretty_generate(response)

results = JSON.parse(response.body)['response']['results']
results.each_with_index do |this, index|
	puts "(#{index + 1} ) " + this["webUrl"]
end
print "Do you want to visit any of the links?: "
answer = gets.chomp

if answer == "yes" || answer == "y"
	print "Enter the number besides the url you want to open: "
	number = gets.chomp.to_i
	Launchy.open(results[number+1]["webUrl"])
end
