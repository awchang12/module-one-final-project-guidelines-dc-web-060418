class User < ActiveRecord::Base
  has_many :saved_hikes
  has_many :hikes, through: :saved_hikes


  #---------------------- METHODS USED IN RUN FILE ----------------------------

    def delete_hike 
      self.display_my_hikes

      puts "\nPlease enter a Hike ID to delete:"
      users_hike_id_response = gets.chomp.gsub(/[.?!:\s]/, "")

      if self.hikes.any?{|hike| hike.id == users_hike_id_response.to_i}

        SavedHike.delete_hike_from_db(users_hike_id_response, self.id)

        puts "You successfully deleted the Hike!\n\n"

      else
        puts "That hike wasn't found in your hikes\n\n"
      end
    end


    def display_my_hikes
        if self.hikes.empty?
            puts "\nYou have 0 saved hikes.\n\n"
        else
          puts "\nHere are your current hikes:\n\n"
            sorted_by_id = self.hikes.sort_by{|hike| hike.id}
            Hike.display_hikes(sorted_by_id)
        end
    end


    def search_by_length

      puts "\nPlease enter a number for MINIMUM DISTANCE:"
      min_distance = gets.chomp.gsub(/[.\s]/, "")

      puts "\nPlease enter a number for MAXIMUM DISTANCE:"
      max_distance = gets.chomp.gsub(/[.\s]/, "")

      hikes_arr = Hike.search_hikes_by_length(min_distance, max_distance)

      if hikes_arr.empty?
        puts "We could not locate any hikes with this input.\nEither input was invalid or hikes could not be found within the given range."
        self.search_by_length
      else
        Hike.display_hikes(hikes_arr)
        self.save_hike_from_search
      end

    end


    def search_by_difficulty
      puts "\nThe difficulty selections are listed below from least strenuous to most strenuous:\ngreen || greenBlue || blue || blueBlack"
      puts "\nPlease enter difficulty"

      user_difficulty = gets.chomp.gsub(/[\s]/, "")

      hikes_arr = Hike.search_hikes_by_difficulty(user_difficulty)

      if hikes_arr.empty?
        puts "\nWe could not locate any hikes with this input.\n\n"
        self.search_by_difficulty
      else
        Hike.display_hikes(hikes_arr)
        self.save_hike_from_search
      end

    end

    def write_review
      self.display_my_hikes

      puts "\nEnter HIKE ID of hike you would like to review:"
      hike_id = gets.chomp.gsub(/[.\s]/, "")

      puts "\nEnter your rating for the hike! 1 being lowest - 5 highest."
      rating = gets.chomp.strip.to_i

      puts "\nWrite a brief statement of your experience!"
      review = gets.chomp.strip

      SavedHike.update_rating_and_review(rating, review, hike_id, self.id)

      puts "\nThanks for your feedback! Your input makes our application more valuable to our users!\n\n"

    end

    def update_review
      self.display_my_hikes

      puts "\nEnter HIKE ID of hike you would like to change:"
      hike_id = gets.chomp.gsub(/[.\s]/, "")

      SavedHike.display_review(hike_id, self.id)

      puts "\nPlease update your rating here:"
      rating = gets.chomp.gsub(/[.\s]/, "")

      puts "\nPlease update your review here:"
      review = gets.chomp.strip

      SavedHike.update_rating_and_review(rating, review, hike_id, self.id)

      puts "\nThanks for your updated feedback!"

    end

    def display_users_reviews
      user_hikes = SavedHike.all.where(user_id: self.id)
      user_hikes.each do |saved_hike|
        if saved_hike.review != nil && saved_hike.rating != nil
          SavedHike.display_review(saved_hike.hike_id, self.id)
        end
      end
    end

    def delete_user_review
      self.display_users_reviews

      puts "\nPlease enter HIKE ID:"
      hike_id = gets.chomp.gsub(/[.\s]/, "")

      SavedHike.display_review(hike_id, self.id)
      SavedHike.update_rating_and_review(nil, nil, hike_id, self.id)

      puts "\nYou successfully deleted this review!"
    end




#------------------------- HELPER METHODS FOR SAVING HIKES -------------------------------------


  def save_hike_from_search
    user_answer = yes_or_no?

    case user_answer
    when "yes" || "y"
      save_yes_sequence
    when "no" || "n"
      puts ""
    else
      puts "\nPlease enter a valid answer\n\n"
      self.save_hike_from_search
    end

  end

  def yes_or_no? #gets user input of yes or no or invalid answer
    puts "Would you like to save a hike? yes or no?"
    users_yes_or_no = gets.chomp.downcase.strip
  end

  def save_yes_sequence
    puts "\nPlease enter a Hike ID"
    users_hike_id_response = gets.chomp.gsub(/[.\s]/, "")
    # Still need to take into account if response is not a number. we will come to it if we have time.
    SavedHike.save_hike(users_hike_id_response, self.id)
    puts "\nThis hike has been saved to your Hikes\n\n"
  end

end
