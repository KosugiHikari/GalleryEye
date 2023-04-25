class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  # 投稿のアソシエーション
  has_many :posts, dependent: :destroy

  # コメントのアソシエーション
  has_many :comments, dependent: :destroy

  # いいねのアソシエーション
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  # フォロー関係のアソシエーション
  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使う
  # throughでスルーするテーブル、sourceで参照するカラムを指定
  # relationshipsテーブルからfollowed_idのデータを、
  # reverse_of_relationshipsテーブルからfollower_idのデータを参照している
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 性別のenum設定
  enum sex: { men:0, women:1, others:2 }

  # バリデーション
  with_options presence: true do
    validates :name, length: { minimum: 1, maximum: 20 }, uniqueness: true
    validates :email
  end

    validates :introduction, length: { maximum: 50 }

  # プロフィール画像を表示させるためのメソッド
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/icon_user.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  # Userモデルで使用できるゲストログインのguestメソッド
  # find_or_create_byは、データの検索と作成を自動的に判断して処理を行う
  # SecureRandom.urlsafe_base64は、ランダムな文字列を生成する
  def self.guest
    find_or_create_by!(name: 'guestuser', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  # 検索（ユーザーネームを検索可能）
  def self.search(keyword)
    where(["name like?", "%#{keyword}%"])
  end

  def self.ransackable_attributes(auth_object = nil)
      ["name","email","birthdate","sex","introduction","is_deleted"]
  end

  def self.ransackable_associations(auth_object = nil)
      ["name","email","birthdate","sex","introduction","is_deleted"]
  end

end
