class Contact < ApplicationRecord
  # バリデーション
  with_options presence: true do
    validates :name
    validates :email
    validates :subject
    validates :message
  end
end
