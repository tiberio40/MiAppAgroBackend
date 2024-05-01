class FieldDiary < ApplicationRecord
    belongs_to :user
    belongs_to :farming
    has_many :notes
end
