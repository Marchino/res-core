class AddMessageIdToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :message_id, :string, index: true
  end
end
