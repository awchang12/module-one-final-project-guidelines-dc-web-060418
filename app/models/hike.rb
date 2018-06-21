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
end


def display_hikes(hike_arr)
    hike_arr.each do |hike|
        puts "\nHIKE ID: #{hike.id}. #{hike.name} - #{hike.location} - #{hike.length} miles - #{hike.difficulty}"
        puts "--------------------------------------------------------------------------------------------"
        puts "#{hike.summary}\n\n"
    end
end
