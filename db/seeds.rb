require 'JSON'
require 'rest-client'
require 'pry'

all_hikes = RestClient.get('https://www.hikingproject.com/data/get-trails?lat=38.9072&lon=-77.0369&maxDistance=35&key=200291356-aa48b6bb79a22162a5f603ec3d2dd4d1&maxResults=150')
json_hash = JSON.parse(all_hikes)

hike_array = json_hash["trails"]


hike_array.each do |hike|
  Hike.create(
    name: hike["name"],
    summary: hike["summary"],
    length: hike["length"],
    difficulty: hike["difficulty"],
    location: hike["location"]
  )
end
