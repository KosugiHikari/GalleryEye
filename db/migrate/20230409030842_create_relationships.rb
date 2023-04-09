class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      
      # フォローしたユーザー
      t.integer :follower_id
      # フォローされたユーザー
      t.integer :followed_id
      
      t.timestamps
    end
  end
end
