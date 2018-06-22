class Hike < ActiveRecord::Base
    has_many :saved_hikes
    has_many :users, through: :saved_hikes

    def self.search_hikes_by_length(min_length, max_length)
        hike_arr = Hike.all.where("length >= ? AND length <= ?",  min_length, max_length)
        sorted_by_id = hike_arr.sort_by {|hike| hike.id}
    end

    def self.search_hikes_by_difficulty(difficulty)
        hike_arr = Hike.all.where("LOWER(difficulty) = ?", difficulty.downcase)
        sorted_by_id = hike_arr.sort_by {|hike| hike.id}
    end

    def self.display_hikes(hike_arr)
        hike_arr.each do |hike|
            avg_rating = SavedHike.all.where(hike_id: hike.id).average(:rating)
            puts "\nHIKE ID: #{hike.id}. #{hike.name} - #{hike.location} - #{hike.length} miles - #{hike.difficulty} - AVERAGE RATING: #{avg_rating}"
            puts "--------------------------------------------------------------------------------------------"
            puts "#{hike.summary}\n\n"
        end
    end
end

