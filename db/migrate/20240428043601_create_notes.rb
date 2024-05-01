class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes, id: :uuid do |t|
      t.string :name
      t.text :body
      t.string :hash

      t.timestamps
    end
  end
end
