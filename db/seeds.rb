# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@admin', password: '000000'
  )

users = User.create!(
  [
    {name: 'tanaka',email: 'tanaka@example.com',password: '000000',is_deleted: false,profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"),filename:"sample-user1.jpg")},
    {name: 'sato',email: 'sato@example.com',password: '000000',is_deleted: false,profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"),filename:"sample-user2.jpg")},
    {name: 'aoki',email: 'aoki@example.com',password: '000000',is_deleted: false,profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"),filename:"sample-user3.jpg")}
  ]
)

posts = Post.create!(
  [
    # File.open("#{Rails.root}/db/fixtures/sample-post1.jpg")はrefile用の画像挿入の記述方法
    {post_image: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), art_exhibition_name: '日本画展', gallery_name: '都立美術館', start_date: '2023-01-01', end_date: '2023-04-30', admission: 1000, holding_area: 13, address: '東京都中央区明石町695-7', shooting_availability: 1, tag_list: '東京,美術館', point: '有名作品以外も多数', body: 'とにかく行ってほしい', user_id: users[0].id },
    {post_image: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), art_exhibition_name: 'ガラス工芸品展', gallery_name: '県立美術館', start_date: '2023-05-01', end_date: '2023-08-31', admission: 800, holding_area: 12, address: '千葉県千葉市中央区南町2-232-19', shooting_availability: 2, tag_list: '美術館,千葉,ガラス工芸品', point: '芸術的な作品', body: 'おすすめです', user_id: users[1].id },
    {post_image: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), art_exhibition_name: '世界の名画展', gallery_name: '都立美術館', start_date: '2023-06-01', end_date: '2023-09-30', admission: 900, holding_area: 13, address: '東京都中央区明石町695-7', shooting_availability: 1, tag_list: '東京,美術館,名画', point: '圧倒されます', body: '興味がない人にも行ってほしい', user_id: users[2].id }
  ]
)

Comment.create!(
  [
    {comment: '面白そう！行ってみます', user_id: users[0].id, post_id: posts[1].id},
    {comment: '開催が楽しみ！', user_id: users[1].id, post_id: posts[2].id}
    ]
  )

Like.create!(
  [
    {user_id: users[0].id, post_id: posts[1].id},
    {user_id: users[0].id, post_id: posts[2].id},
    {user_id: users[1].id, post_id: posts[1].id},
    {user_id: users[1].id, post_id: posts[2].id},
    {user_id: users[2].id, post_id: posts[1].id}
    ]
  )