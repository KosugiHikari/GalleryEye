class RemovePostImageFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :post_image, :string
  end
end
