class RemoveSubjectFromContacts < ActiveRecord::Migration[6.1]
  def change
    remove_column :contacts, :subject, :integer
  end
end
