class Grade < ActiveRecord::Base
	belongs_to :student
	belongs_to :quiz
	validates :student_id, presence: true
	validates :quiz_id, presence: true
end
