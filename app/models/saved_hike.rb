class SavedHike < ActiveRecord::Base
    belongs_to :user
    belongs_to :hike

#----------------------- HELPER METHODS FOR CRUD ACTIONS ON SAVEDHIKE TABLE -------------------------


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

    def self.update_rating_and_review(rating, review, hike_id, user_id)
        hike = SavedHike.find_or_create_by(user_id: user_id, hike_id: hike_id)
        hike.update(rating: rating, review: review)
    end


    def self.display_review(hike_id, user_id)
        saved_hike = SavedHike.where(user_id: user_id, hike_id: hike_id)
        hike = Hike.all.where(id: hike_id)
        puts "\nHIKE ID: #{hike_id} - #{hike[0].name}\n-----------------------------------------"
        puts "Rating: #{saved_hike[0].rating}  --- #{saved_hike[0].review}"
    end

    def self.save_hike(hike_id, user_id)
        SavedHike.find_or_create_by(
            user_id: user_id,
            hike_id: hike_id
        )
    end

    def self.delete_hike_from_db(hike_id, user_id)
        SavedHike.where(user_id: user_id, hike_id: hike_id).destroy_all
    end
  
end