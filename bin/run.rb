require_relative '../config/environment'
require_relative './run_helper'

#---- RUNS THE CLI APP -----

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

  when "writereview"
    user = User.find_by_id(user.id)
    user.write_review

  when "updatereview"
    user = User.find_by_id(user.id)
    user.update_review

  when "displaymyreviews"
    user = User.find_by_id(user.id)
    user.display_users_reviews

  when "deleteareview"
    user = User.find_by_id(user.id)
    user.delete_user_review

  when "readreviews"
    user = User.find_by_id(user.id)
    SavedHike.read_reviews

  else
    invalid_command

  end

  help
  response = get_user_command

end

exit
