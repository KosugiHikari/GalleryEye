class Post < ApplicationRecord
  
  belongs_to :user
  
  has_one_attached :image
  
  # enum設定
  enum shooting_availability: {shooting_not_possible:0, shooting_allowed:1, unknown:2}
  validates :art_exhibition_name, presence: true
  validates :gallery_name, presence: true
  validates :point, presence: true
  validates :body, presence: true
end
