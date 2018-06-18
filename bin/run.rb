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
    - save hike: saves a given hike to your hikes.
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
    end
    puts "please enter a command:"
    user_response = gets.chomp
end

exit