class Post < ApplicationRecord

  has_one_attached :image

  belongs_to :user, optional: true

  # コメントのアソシエーション
  has_many :comments, dependent: :destroy

  # いいねのアソシエーション
  has_many :likes, dependent: :destroy

  attachment :post_image
  
  # acts_as_taggable_on :tags の省略
  acts_as_taggable

  # enum設定
  enum shooting_availability: {shooting_not_possible:0, shooting_allowed:1, unknown:2}

  validates :art_exhibition_name, presence: true
  validates :gallery_name, presence: true
  validates :point, presence: true
  validates :body, presence: true

  # ログイン中のユーザーがその投稿に対していいねをしているかを判断するメソッド
  def liked?(user)
    likes.exists?(user_id: user_id)
  end

end
