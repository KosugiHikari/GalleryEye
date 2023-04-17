class RenameAreaColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :area, :holding_area
  end
end
