class CreateSavedHikesTable < ActiveRecord::Migration[4.2]
    def change
        create_table :saved_hikes do |t|
            t.integer :user_id
            t.integer :hike_id
        end
    end
end