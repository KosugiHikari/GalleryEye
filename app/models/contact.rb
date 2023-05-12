class Contact < ApplicationRecord

  # enum設定
  # 問い合わせ内容
  enum subject: {
    レビュー全般について:0,
    アカウント情報について:1,
    運営について:2,
    その他:3
  }

  # バリデーション
  with_options presence: true do
    validates :name
    validates :email
    validates :subject
    validates :message
  end
end
