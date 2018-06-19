class User < ActiveRecord::Base
  has_many :saved_hikes
  has_many :hikes, through: :saved_hikes


    def delete_hike
      self.display_my_hikes

      puts "Please enter a Hike ID to delete:"
      users_hike_id_response = gets.chomp

      if self.hikes.any?{|hike| hike.id == users_hike_id_response.to_i}

        self.delete_hike_from_db(users_hike_id_response)

        puts "You successfully deleted the Hike!"
        puts ""

      else
        puts "That hike wasn't found in your hikes"
        puts ""
      end
    end


    def display_my_hikes
        if self.hikes.empty?
            puts "You have 0 saved hikes."
        else
          puts "Here are your current hikes:"
          puts ""
            self.hikes.each do |hike|
                puts "HIKE ID: #{hike.id}. #{hike.name} - #{hike.length} miles - #{hike.difficulty}"
                puts "-------------------------------------------------------------"
                puts "#{hike.summary}"
                puts ""
            end
        end
    end


    def search_by_length

      puts "Please enter minimum distance:"
      min_distance = gets.chomp

      puts "Please enter maximum distance:"
      max_distance = gets.chomp


      if self.search_hikes_by_length(min_distance, max_distance).empty?
        puts "We could not locate any hikes with this input."
        puts "Either input was invalid or hikes could not be found within the given range."
        self.search_by_length
      else

        # self.search_hikes_by_length(min_distance, max_distance)
        self.save_hike_from_search
      end

    end


    def save_hike_from_search
      puts "Would you like to save a hike? yes or no?"
      puts ""

      users_yes_or_no = gets.chomp

      if users_yes_or_no == "yes"
          puts "Please enter a Hike ID"
          users_hike_id_response = gets.chomp

          self.save_hike(users_hike_id_response)

          puts "Hike has been saved to your Hikes"
      end

      puts ""
    end


    def search_by_difficulty
      puts "The difficulty selections are listed below:
      - green -       least strenuous
      - greenBlue -         |
      - blue-               |
      - blueBlack -         |
      - black -       most strenuous"
      puts ""
      puts "Please enter difficulty"

      user_difficulty = gets.chomp

      self.search_hikes_by_difficulty(user_difficulty)
    end






#------------ HELPER METHODS -------------------------------------

  def save_hike(num)

      SavedHike.find_or_create_by(
          user_id: self.id,
          hike_id: num
      )

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

  def delete_hike_from_db(num)
      SavedHike.where(user_id: self.id, hike_id: num).destroy_all
      self.hikes.delete(hike_id: num)
  end

end
