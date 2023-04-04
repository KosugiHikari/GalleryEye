class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      
      t.integer :user_id #外部キー
      t.string :art_exhibition_name #美術展名
      t.string :gallery_name #美術館名
      t.date :sitting #会期
      t.integer :admission #入場料
      t.integer :prefectures #都道府県
      t.string :address #住所
      t.integer :shooting_availability #撮影可否
      t.string :point #注目ポイント
      t.string :body #本文
      t.string :star #5段階評価の星
      t.string :image #画像
      t.string :comment #コメント
      
      t.timestamps
    end
  end
end
