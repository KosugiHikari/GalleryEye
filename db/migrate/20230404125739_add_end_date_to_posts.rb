class AddEndDateToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :end_date, :date
  end
end
