require "http"
require "json"
require "dotenv/load"
require "active_support/all"

pp "Will you need an umbrella today?"

pp "Where are you?"

# user_location = gets.chomp

user_location = "Madrid"

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")


raw_response= HTTP.get(maps_url).to_s


parsed_response = JSON.parse(raw_response)

# pp parsed_response.keys

results = parsed_response.fetch ("results")

results2= results.at(0)

geometry = results2.fetch("geometry")
  
location= geometry.fetch("location")

pp latitude = location.fetch("lat")

pp longitude = location.fetch("lng")
