class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts, dependent: :destroy
  
  has_one_attached :profile_image
  
  # enum設定
  enum sex: { men:0, women:1, others:2 }
  
  validates :name, presence: true
  validates :email, presence: true

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/icon-user.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jp', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_lomit: [width, height]).processed
  end
end
