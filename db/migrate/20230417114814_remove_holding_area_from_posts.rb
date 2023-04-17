class RemoveHoldingAreaFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :holding_area, :integer
  end
end
