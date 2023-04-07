class AddPostImageIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :post_image_id, :string
  end
end
