class CreateFieldDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :field_diaries, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
