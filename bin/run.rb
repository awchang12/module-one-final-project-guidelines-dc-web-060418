require_relative '../config/environment'

def welcome 

    puts "Welcome to our hiking application!"

end

def get_user_name
    puts "please enter your username"

    user_name = gets.chomp

    user = User.find_or_create_by(name: user_name)

    puts "thanks #{user.name}!"
    
    user
end

def help
    puts "I accept the following commands:
    - help: displays this help message.
    - search by length: searches the list of hikes between given paramters.
    - search by difficulty: searches list of hikes based on difficulty.
    - my hikes: displays a list of your saved hikes.
    - delete hike: deletes desired hike from your saved hikes.
    - exit: exits this program."
end

def exit
    puts "HAPPY HIKING!!!"
end


welcome

user = get_user_name

help

puts "please enter a command:"

user_response = gets.chomp.downcase

until user_response == "exit"
    if user_response == "search by length"
        puts "please enter minimum distance:"
        
        min_distance = gets.chomp
       
        puts "please eneter maximum distance:"

        max_distance = gets.chomp

        user.search_hikes_by_length(min_distance, max_distance)
    
        puts "Would you like to save a hike? yes or no?"

        puts ""

        users_yes_or_no = gets.chomp

        if users_yes_or_no == "yes"
            puts "Please enter a Hike ID"

            users_hike_id_response = gets.chomp

            user.save_hike(users_hike_id_response)

            puts "Hike has been saved to your hikes"
     
        end

        puts ""
    
    elsif user_response == "search by difficulty"
        puts "The difficulty selections are listed below:
        - green - least strenuous
        - greenBlue -
        - blue- 
        - blueBlack -
        - black - most strenuous"

        puts "please enter difficulty"
        
        user_difficulty = gets.chomp

        user.search_hikes_by_difficulty(user_difficulty)

        puts "Would you like to save a hike? yes or no?"

        puts ""

        users_yes_or_no = gets.chomp

        if users_yes_or_no == "yes"
            puts "Please enter a Hike ID"

            users_hike_id_response = gets.chomp

            puts "Hike has been saved to your hikes"

            user.save_hike(users_hike_id_response)
            
            
        end

        puts ""

    elsif user_response == "my hikes"
        puts "Your awesome hikes"
        user.display_my_hikes

    elsif user_response == "delete hike"
        user.display_my_hikes
        
        puts "Please enter a Hike ID"

        users_hike_id_response = gets.chomp

        user.delete_hike(users_hike_id_response)

        puts ""

    else
        puts "please enter valid command"
        puts ""

    end
    help

    puts "please enter a command:"
    user_response = gets.chomp
end

exit