require_relative '../config/environment'
require_relative './run_helper'

#---- runs the cli app ---

welcome
# byebug
user = get_user_name
help
response = get_user_command

until response == "exit"
  case response
  when "search by length"
      user.search_by_length
      # user.save_hike_from_search

  when "search by difficulty"
      user.search_by_difficulty
      user.save_hike_from_search

  when "my hikes"
    user = User.find_by_id(user.id)
    user.display_my_hikes

  when "delete hike"
    user.delete_hike

  else
    invalid_command

  end

  help
  response = get_user_command

end

exit
