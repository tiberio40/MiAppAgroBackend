class AddDateToNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :createdDate, :string
    remove_column :notes, :hash
  end
end
