class Post < ApplicationRecord

  # enum設定
  enum shooting_availability: {shooting_not_possible:0, shooting_allowed:1, unknown:2}
end
