class CreateMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :maps do |t|
      
      t.string :prefectures_name #都道府県名
      t.timestamps
    end
  end
end
