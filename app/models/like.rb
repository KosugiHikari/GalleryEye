class Like < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :post
end
