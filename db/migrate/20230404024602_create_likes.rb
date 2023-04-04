class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      
      t.integer :user_id #外部キー
      t.integer :post_id #外部キー
      t.timestamps
    end
  end
end
