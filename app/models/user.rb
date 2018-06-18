class User < ActiveRecord::Base
    has_many :saved_hikes
    has_many :hikes, through: :saved_hikes

    def save_hike(hike)
        SavedHike.find_or_create_by(
            user_id: self.id,
            hike_id: hike.id
        )
    end

    def delete_hike(hike)
        SavedHike.where(user_id: self.id, hike_id: hike.id).destroy_all
        self.hikes.delete(hike_id: hike.id)

        return "you successfully delete #{hike.name}!"
    end

    def display_my_hikes
        i = 1

        self.hikes.each do |hike|
            puts "#{i}. #{hike.name} - #{hike.length} miles - #{hike.difficulty}"
            puts "-------------------------------------------------------------"
            puts "#{hike.summary}"
            puts ""
            i+=1
        end
    end


    def search_hikes_by_difficulty(difficulty)
        hike_arr = Hike.all.where(difficulty: difficulty)

        i = 1

        hike_arr.each do |hike|
            puts "#{i}. #{hike.name} - #{hike.length} miles - #{hike.difficulty}"
            puts "-------------------------------------------------------------"
            puts "#{hike.summary}"
            puts ""
            i += 1
        end
    end

    def search_hikes_by_length(min_length, max_length)

        hike_arr = Hike.all.where("length > ? AND length < ?",  min_length, max_length)

        i = 1

        hike_arr.each do |hike|
            puts "#{i}. #{hike.name} - #{hike.length} miles - #{hike.difficulty}"
            puts "-------------------------------------------------------------"
            puts "#{hike.summary}"
            puts ""
            i += 1
        end
    end


end