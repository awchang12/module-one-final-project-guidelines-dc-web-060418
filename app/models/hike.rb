class Hike < ActiveRecord::Base
    has_many :saved_hikes
    has_many :users, through: :saved_hikes
end