class AddScoreToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :score, :integer, index: true
  end
end
