class RemoveSittingFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :sitting, :date
  end
end
