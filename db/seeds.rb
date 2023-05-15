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

User.create!(
  name: 'tanaka',
  email: 'tanaka@example.com',
  password: '000000',
  is_deleted: false,
  profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"),
  filename:"sample-user1.jpg")
  )
User.create!(
  name: 'sato',
  email: 'sato@example.com',
  password: '000000',
  is_deleted: false,
  profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"),
  filename:"sample-user2.jpg")
  )
User.create!(
  name: 'aoki',
  email: 'aoki@example.com',
  password: '000000',
  is_deleted: false,
  profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"),
  filename:"sample-user3.jpg")
  )