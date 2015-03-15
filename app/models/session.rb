class Session < ActiveRecord::Base
	has_and_belongs_to_many :students
	has_and_belongs_to_many :subjects
	belongs_to :tutor

	scope :upcoming, -> { where(status: 0) }

	validates :students, length: {minimum: 1}
	validates :subjects, length: {minimum: 1}
	validates :time, presence: true
	validates :location, presence: true
	validates :duration, presence: true, numericality: {greater_than: 0}
	validates :price, presence: true, numericality: {greater_than: 0}
	validate  :validPrice
	validates :status, presence: true

	def validPrice
		tutor = Tutor.find(tutor_id)
		high = tutor.certifications.collect{|x| x.wage.to_i}.sort[-1]
		low = tutor.certifications.collect{|x| x.wage.to_i}.sort[0]
		if price > high || price < low
			errors.add(:price, "must be between #{low} and #{high}")
		end
	end

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
