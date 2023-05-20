class Post < ApplicationRecord

  # refileによる画像投稿
  attachment :post_image

  belongs_to :user, optional: true

  # コメントのアソシエーション
  has_many :comments, dependent: :destroy

  # いいねのアソシエーション
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # acts_as_taggable_on :tags の省略
  acts_as_taggable

  # カラムデータの取り出し方を支持する記述
  # order：データの取り出し　desc：昇順　asc：降順
  scope :new_post, -> {order(created_at: :desc)}
  scope :old_post, -> {order(created_at: :asc)}


  # enum設定
  # 撮影可否
  enum shooting_availability: {shooting_not_possible:0, shooting_allowed:1, unknown:2}

  # 地域
  enum holding_area: {
     選択なし:0,
     北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
     茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
     新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
     岐阜県:21,静岡県:22,愛知県:23,三重県:24,
     滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
     鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
     徳島県:36,香川県:37,愛媛県:38,高知県:39,
     福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
     沖縄県:47
  }

  # バリデーション
  # 下書きの状態ではバリデーションをかけない
  with_options presence: true, unless: :draft? do
    validates :art_exhibition_name, length: { maximum: 20 }
    validates :gallery_name, length: { maximum: 20 }
    validates :start_date
    validates :end_date
    validates :holding_area
    validates :shooting_availability
    validates :point, length: { maximum: 20 }
    validates :body, length: { maximum: 500 }
  end

  # 終了日が開始日より前にならないようにするためのバリデーション
  validate :start_end_check
  def start_end_check
    return if self.is_draft
    errors.add(:end_date, "は開始日より前の日付は登録できません") unless
    if self.start_date && self.end_date
      self.start_date < self.end_date
    end
  end


  # ログイン中のユーザーがその投稿に対していいねをしているかを判断するメソッド
  def liked?(user)
    likes.exists?(user_id: user.id)
  end

  # バリデーションの条件分岐に使用しているメソッド
  def draft?
    is_draft == true
  end

  def self.ransackable_attributes(auth_object = nil)
      ["art_exhibition_name","gallery_name","address","shooting_availability","point","body","holding_area","start_date","end_date","is_draft"]
  end

  def self.ransackable_associations(auth_object = nil)
      ["art_exhibition_name","gallery_name","address","shooting_availability","point","body","holding_area","start_date","end_date","is_draft"]
  end

end
