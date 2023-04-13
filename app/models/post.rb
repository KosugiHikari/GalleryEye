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

  # カラムデータの取り出し方を支持する記述
  # order：データの取り出し　desc：昇順　asc：降順
  scope :new_post, -> {order(created_at: :desc)}
  scope :old_post, -> {order(created_at: :asc)}
  scope :like_many, -> {order(created_at: :desc)}
  scope :like_few, -> {order(created_at: :asc)}


  # enum設定
  enum shooting_availability: {shooting_not_possible:0, shooting_allowed:1, unknown:2}

  # バリデーション
  with_options presence: true, on: :publicize do
    validates :art_exhibition_name
    validates :gallery_name
    validates :admission
    validates :shooting_availability
    validates :point
    validates :body
  end


  # ログイン中のユーザーがその投稿に対していいねをしているかを判断するメソッド
  def liked?(user)
    likes.exists?(user_id: user_id)
  end

  # 検索分岐（美術展名・美術館名・住所・注目ポイント・本文から検索可能）
  def self.search(keyword)
    where(["art_exhibition_name like?", "%#{keyword}%"]).
    or(where(["gallery_name like?", "%#{keyword}%"])).
    or(where(["address like?", "%#{keyword}%"])).
    or(where(["point like?", "%#{keyword}%"])).
    or(where(["body like?", "%#{keyword}%"]))
  end

end
