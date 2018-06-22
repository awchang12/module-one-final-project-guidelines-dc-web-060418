class AddColumnRatingReviewSavedhikes < ActiveRecord::Migration[4.2]

  def change
    add_column :saved_hikes, :rating, :integer
    add_column :saved_hikes, :review, :text
  end 

end
