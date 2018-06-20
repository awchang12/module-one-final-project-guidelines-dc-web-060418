# require 'require_all'
# require_all 'app'
require 'JSON'
require 'rest-client'
require 'pry'

all_hikes = RestClient.get('https://www.hikingproject.com/data/get-trails?lat=38.9072&lon=-77.0369&maxDistance=35&key=200291356-aa48b6bb79a22162a5f603ec3d2dd4d1&maxResults=500')
json_hash = JSON.parse(all_hikes)

hike_array = json_hash["trails"]









#--------------------other seeds ---------------------------------------
# Hike.create(
#     name: "Great Falls Park",
#     summary: "A tour of some great trails in the south end of GFNP culminating with dramatic view of the falls.",
#     length: 3.3,
#     difficulty: "blue"
#     )
#
# Hike.create(
#     name: "Ronald Craven Trail",
#     summary: "A very nice and simple hike around Lake Royal.",
#     length: 1.7,
#     difficulty: "greenBlue"
# )
#
# Hike.create(
#     name: "Berma Road to Billy Goat Trail Section A",
#     summary: "A nice morning hike, the Billy Goat Trail Section A has a few tricky spots.",
#     length: 3.5,
#     difficulty: "blueBlack"
# )
#
# Hike.create(
#     name: "Burke Lake Trail",
#     summary: "One of the best hikes in Northern Virginia",
#     length: 4.4,
#     difficulty: "greenBlue"
# )
#
# Hike.create(
#     name: "Second Battle of Manassas Trail",
#     summary: "A great route on well maintained trails in the Manassas Battlefield National Park.",
#     length: 6.3,
#     difficulty: "greenBlue"
# )
#
# User.create(
#     name: "August Giles"
# )
#
# User.create(
#     name: "Anthony Chang"
# )
