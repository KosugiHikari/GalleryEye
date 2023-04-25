class RemoveStarFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :star, :string
  end
end
