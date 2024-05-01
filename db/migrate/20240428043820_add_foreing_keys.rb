class AddForeingKeys < ActiveRecord::Migration[6.1]
  def change
    add_reference :field_diaries, :user, type: :uuid, foreign_key: true
    add_reference :notes, :field_diary, type: :uuid, foreign_key: true
    add_reference :field_diaries, :farming, type: :uuid, foreign_key: true
  end
end
