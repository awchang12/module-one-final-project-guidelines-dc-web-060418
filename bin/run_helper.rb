require_relative '../config/environment'

def welcome
    puts "Welcome to our Hiking Application!"
end

def get_user_name
    puts "Please enter your Username:"
    user_name = gets.chomp
    user = User.find_or_create_by(name: user_name)
    puts "Welcome, #{user.name}!"
    user
end

def help
    puts "I accept the following commands:
    - search by length:      searches the list of hikes between given parameters.
    - search by difficulty:  searches the list of hikes based on difficulty.
    - my hikes:              displays a list of your saved hikes.
    - delete hike:           deletes specified hike from your saved hikes.
    - exit:                  exits this program."
end

def exit
    puts "HAPPY HIKING!!!"
end

def get_user_command
  puts "Please enter a command:"
  gets.chomp.downcase
end

def invalid_command
  puts ""
  puts "Please enter a valid command"
  puts ""
end
