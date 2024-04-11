pp "howdy"

pp "Where are you located?"

user_location = gets.chomp

# Assuming you have set up the ENV variables correctly.
maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

require "http"

resp = HTTP.get(maps_url)

# Call `.to_s` on the response's body to get the raw string
raw_response = resp.body.to_s

require "json"

parsed_response = JSON.parse(raw_response)

results = parsed_response.fetch("results")

first_result = results.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")  # Correct the spelling here

# Hidden variables
pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_API_KEY")

# Interpolate the latitude and longitude values into the URL string
pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_api_key}/#{latitude},#{longitude}"

# Place a GET request to the URL
raw_response = HTTP.get(pirate_weather_url)

# The response is already a string, so we don't need to call `to_s` again
parsed_response = JSON.parse(raw_response)

currently_hash = parsed_response.fetch("currently")

current_temp = currently_hash.fetch("temperature")

puts "The current temperature is " + current_temp.to_s + "."

hourly_hash = parsed_response.fetch("hourly")

sum = hourly_hash.fetch("summary")

puts "The weather for the next hour is " + sum.to_s.downcase + "."
