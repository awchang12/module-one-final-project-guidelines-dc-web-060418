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
            Hike.display_hikes(sorted_by_id)
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
      id = gets.chomp.strip

      puts "\nEnter your rating for the hike! 1 being lowest - 5 highest."
      rating = gets.chomp.strip.to_i

      puts "\nWrite a brief statement of your experience!"
      review = gets.chomp.strip

      self.update_rating_and_review(rating, review, id)

      puts "\nThanks for your feedback! Your input makes our application more valuable to our users!\n\n"

    end

    def update_review
      self.display_my_hikes

      puts "\nEnter HIKE ID of hike you would like to change:"
      id = gets.chomp.strip

      self.display_review(id)

      puts "\nPlease update your rating here:"
      rating = gets.chomp.strip

      puts "\nPlease update your review here:"
      review = gets.chomp.strip

      self.update_rating_and_review(rating, review, id)

      puts "\nThanks for your updated feedback!"

    end

    def display_users_reviews
      user_hikes = SavedHike.all.where(user_id: self.id)
      user_hikes.each do |saved_hike|
        if saved_hike.review != nil && saved_hike.rating != nil
          display_review(saved_hike.hike_id)
        end
      end
    end

    def delete_user_review
      self.display_users_reviews

      puts "\nPlease enter HIKE ID:"
      id = gets.chomp.strip

      display_review(id)
      update_rating_and_review(nil, nil, id)

      puts "\nYou successfully deleted this review!"
    end





#------------ HELPER METHODS -------------------------------------

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
    self.save_hike(users_hike_id_response)
    puts "\nThis hike has been saved to your Hikes\n\n"
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

  def update_rating_and_review(rating, review, hike_id)
    hike = SavedHike.where(user_id: self.id, hike_id: hike_id)
    hike.update(rating: rating, review: review)
  end

  def display_review(hike_id)
    saved_hike = SavedHike.where(user_id: self.id, hike_id: hike_id)
    hike = Hike.all.where(id: hike_id)
    puts "\nHIKE ID: #{hike_id} - #{hike[0].name}\n-----------------------------------------"
    puts "Rating: #{saved_hike[0].rating}  --- #{saved_hike[0].review}"
  end

end
