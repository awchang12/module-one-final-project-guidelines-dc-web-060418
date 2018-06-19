class User < ActiveRecord::Base
    has_many :saved_hikes
    has_many :hikes, through: :saved_hikes

    def save_hike(num)

        SavedHike.find_or_create_by(
            user_id: self.id,
            hike_id: num
        )
        # if !user.hikes.include?(Hikes.find_by_id(num))
        #     user.hikes << Hikes.find_by_id(num)
        # end
    end

    def delete_hike(num)
        SavedHike.where(user_id: self.id, hike_id: num).destroy_all
        self.hikes.delete(hike_id: num)

        puts "you successfully deleted the hike!"
    end

    def display_my_hikes
        if self.hikes.empty?
            puts "You have 0 saved hikes."
        else
            self.hikes.each do |hike|
                puts "HIKE ID: #{hike.id}. #{hike.name} - #{hike.length} miles - #{hike.difficulty}"
                puts "-------------------------------------------------------------"
                puts "#{hike.summary}"
                puts ""
            end
        end
    end


    def search_hikes_by_difficulty(difficulty)
        hike_arr = Hike.all.where("LOWER(difficulty) = ?", difficulty.downcase)


        hike_arr.each do |hike|
            puts "HIKE ID: #{hike.id}. #{hike.name} - #{hike.length} miles - #{hike.difficulty}"
            puts "-------------------------------------------------------------"
            puts "#{hike.summary}"
            puts ""
        end
    end

    def search_hikes_by_length(min_length, max_length)

        hike_arr = Hike.all.where("length > ? AND length < ?",  min_length, max_length)


        hike_arr.each do |hike|
            puts "HIKE ID: #{hike.id}. #{hike.name} - #{hike.length} miles - #{hike.difficulty}"
            puts "-------------------------------------------------------------"
            puts "#{hike.summary}"
            puts ""
        end
    end


end