class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :subject
      t.text :body
      t.string :from
      t.datetime :sent_at, index: true
      t.boolean :published, index: true

      t.timestamps
    end
  end
end
