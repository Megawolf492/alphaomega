class Hiring < ActiveRecord::Base
    belongs_to :student
    belongs_to :tutor

    validates :student_id, presence: true
    validates :tutor_id, presence: true
end
