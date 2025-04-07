require "http"
require "json"
require "dotenv/load"
require "active_support/all"

pp "Will you need an umbrella today?"

pp "Where are you?"

user_location = gets.chomp

#user_location = "Madrid"

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")


raw_response= HTTP.get(maps_url).to_s


parsed_response = JSON.parse(raw_response)

# pp parsed_response.keys

results = parsed_response.fetch ("results")

results2= results.at(0)

geometry = results2.fetch("geometry")
  
location= geometry.fetch("location")

pp latitude = location.fetch("lat").to_s

pp longitude = location.fetch("lng").to_s


#Take the latitude and longitude, assemble the correct URL for the Pirate Weather API, get it, parse it, and dig out current temperature


pirate_weather_url = "https://api.pirateweather.net/forecast/" + ENV.fetch("PIRATE_WEATHER_KEY") + "/" + latitude+ "," + longitude

raw_pw_response = HTTP.get(pirate_weather_url)

parsed_pw_response = JSON.parse(raw_pw_response)

# pp parsed_pw_response.keys

currently_hash = parsed_pw_response.fetch("currently")

current_temp = currently_hash.fetch("temperature")

puts "The current temperature is " + current_temp.to_s + "°F."

# get hourly data

hourly_hash = parsed_pw_response.fetch("hourly")

summary = hourly_hash.fetch("summary")

pp "The weather conditions next hour will be " + summary.to_s.downcase + "."
