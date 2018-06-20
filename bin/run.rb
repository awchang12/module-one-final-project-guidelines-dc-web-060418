require_relative '../config/environment'
require_relative './run_helper'

#---- runs the cli app ---

welcome
user = get_user_name
help
response = get_user_command

until response == "exit"
  case response
  when "searchbylength"
      user.search_by_length

  when "searchbydifficulty"
      user.search_by_difficulty

  when "myhikes"
    user = User.find_by_id(user.id)
    user.display_my_hikes

  when "deletehike"
    user = User.find_by_id(user.id)
    user.delete_hike

  else
    invalid_command

  end

  help
  response = get_user_command

end

exit
