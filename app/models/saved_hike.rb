class SavedHike < ActiveRecord::Base
    belongs_to :user
    belongs_to :hike


    def self.read_reviews
        puts "\nPlease enter a HIKE ID:"
        id = gets.chomp.strip

        get_reviews(id)
    end

    def self.get_reviews(hike_id)
        saved_hikes = SavedHike.all.where(hike_id: hike_id)
        hike = Hike.all.where(id: hike_id)
        puts "\nReviews for #{hike[0].name}:\n\n"

        saved_hikes.each do |save_hike|
            puts "rating: #{save_hike.rating} - review: #{save_hike.review}\n\n"
        end
    end
end