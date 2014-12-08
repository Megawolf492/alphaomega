class Session < ActiveRecord::Base
	has_and_belongs_to_many :students
	has_and_belongs_to_many :subjects
	belongs_to :tutor

	def subjects=(inputData)
		subs = inputData
		subj = Subject.find(subs)
		self.subjects << subj unless self.subjects.include?(subj)
	end

	def students=(inputData)
		subs = inputData
		stud = Student.find(subs)
		self.students << stud unless self.students.include?(stud)
	end
end
