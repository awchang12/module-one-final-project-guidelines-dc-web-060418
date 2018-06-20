require_relative '../config/environment'

def welcome
    puts "\nWelcome to our Hiking Application!\n\nWe've collected for you a list of hikes around the D.C. region!\nIn this application you will be able to search the region for your soon to be favorite hikes!\n\n"
end

def get_user_name
    puts "Please enter your Username:"
    user_name = gets.chomp.strip
    user = User.find_or_create_by(name: user_name)
    puts "\nWelcome, #{user.name}!"
    user
end

def help
    puts "\nI accept the following commands:
    - search by length:      searches the list of hikes by distance in miles.
    - search by difficulty:  searches the list of hikes based on difficulty.
    - my hikes:              displays a list of your saved hikes.
    - delete hike:           deletes specified hike from your saved hikes.
    - exit:                  exits this program.\n\n"
end

def exit
    puts "\nHAPPY HIKING!!!"
end

def get_user_command
  puts "Please enter a command:"
  gets.chomp.downcase.gsub(/[.:!?\s]/, "")
end

def invalid_command
  puts "\nPlease enter a valid command\n\n"
end
