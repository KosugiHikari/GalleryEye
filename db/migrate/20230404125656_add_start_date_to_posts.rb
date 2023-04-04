class AddStartDateToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :start_date, :date
  end
end
