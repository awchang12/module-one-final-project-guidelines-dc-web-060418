class User < ActiveRecord::Base
  has_many :saved_hikes
  has_many :hikes, through: :saved_hikes


    def delete_hike
      self.display_my_hikes

      puts "\nPlease enter a Hike ID to delete:"
      users_hike_id_response = gets.chomp.gsub(/[.?!:\s]/, "")

      if self.hikes.any?{|hike| hike.id == users_hike_id_response.to_i}

        self.delete_hike_from_db(users_hike_id_response)

        puts "You successfully deleted the Hike!\n\n"

      else
        puts "That hike wasn't found in your hikes\n\n"
      end
    end


    def display_my_hikes
        if self.hikes.empty?
            puts "You have 0 saved hikes.\n\n"
        else
          puts "\nHere are your current hikes:\n\n"
            sorted_by_id = self.hikes.sort_by{|hike| hike.id}
            display_hikes(sorted_by_id)
        end
    end


    def search_by_length

      puts "\nPlease enter a number for minimum distance:"
      min_distance = gets.chomp.strip

      puts "\nPlease enter a number for maximum distance:"
      max_distance = gets.chomp.strip

      hikes_arr = Hike.search_hikes_by_length(min_distance, max_distance)

      if hikes_arr.empty?
        puts "We could not locate any hikes with this input.\nEither input was invalid or hikes could not be found within the given range."
        self.search_by_length
      else
        display_hikes(hikes_arr)
        self.save_hike_from_search
      end

    end



    def search_by_difficulty
        puts "\nThe difficulty selections are listed below\nfrom least strenuous to most strenuous:\ngreen || greenBlue || blue || blueBlack || black"
      puts "\nPlease enter difficulty"

      user_difficulty = gets.chomp.gsub(/[\s]/, "")

      hikes_arr = Hike.search_hikes_by_difficulty(user_difficulty)

      if hikes_arr.empty?
        puts "\nWe could not locate any hikes with this input.\n\n"
        self.search_by_difficulty
      else
        display_hikes(hikes_arr)
        self.save_hike_from_search
      end

    end


#------------ HELPER METHODS -------------------------------------

  def save_hike_from_search
    puts "Would you like to save a hike? yes or no?\n\n"

    users_yes_or_no = gets.chomp.downcase.strip

    if users_yes_or_no == "yes" || users_yes_or_no == "y"
        puts "\nPlease enter a Hike ID"
        users_hike_id_response = gets.chomp.gsub(/[.\s]/, "")

        self.save_hike(users_hike_id_response)

        puts "\nThis hike has been saved to your Hikes\n\n"
    end
  end

  def save_hike(num)
      SavedHike.find_or_create_by(
          user_id: self.id,
          hike_id: num
      )
  end


  def delete_hike_from_db(num)
      SavedHike.where(user_id: self.id, hike_id: num).destroy_all
      self.hikes.delete(hike_id: num)
  end

end
