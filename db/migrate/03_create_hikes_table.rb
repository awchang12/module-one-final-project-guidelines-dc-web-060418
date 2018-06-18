class CreateHikesTable < ActiveRecord::Migration[4.2]
    def change
        create_table :hikes do |t|
            t.string :name
            t.string :summary
            t.float :length
            t.string :difficulty
        end
    end
end