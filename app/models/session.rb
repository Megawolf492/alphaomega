class Session < ActiveRecord::Base
	has_and_belongs_to_many :students
	has_and_belongs_to_many :subjects
	belongs_to :tutor
end
