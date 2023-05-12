class AddSubjectToContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :subject, :integer
  end
end
