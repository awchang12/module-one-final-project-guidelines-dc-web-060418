class AddColumnLocationToHikes < ActiveRecord::Migration[4.2]

def change
  add_column :hikes, :location, :string
end

end
