class Viewing < ActiveRecord::Base
	belongs_to :student
	belongs_to :video
	validates :student_id, presence: true
	validates :video_id, presence: true
end
