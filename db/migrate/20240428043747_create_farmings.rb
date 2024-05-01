class CreateFarmings < ActiveRecord::Migration[6.1]
  def change
    create_table :farmings, id: :uuid do |t|
      t.string :name
      t.string :icon

      t.timestamps
    end
  end
end
