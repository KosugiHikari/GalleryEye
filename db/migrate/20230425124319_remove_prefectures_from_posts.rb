class RemovePrefecturesFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :prefectures, :integer
  end
end
