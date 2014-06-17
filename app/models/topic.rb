class Topic < ActiveRecord::Base
	belongs_to :subject
	has_many :videos, dependent: :destroy
	has_many :worksheets, dependent: :destroy
	has_many :quizzes, as: :quizParent, dependent: :destroy

	validates :name, presence: true, length: {maximum: 40}
	validates :description, presence: true, length: {maximum: 4000}
	validates_associated :videos, presence: true
	validates_associated :worksheets, presence: true
	validates_associated :quizzes, presence: true

	accepts_nested_attributes_for :videos, allow_destroy: true
	accepts_nested_attributes_for :worksheets, allow_destroy: true
	accepts_nested_attributes_for :quizzes, allow_destroy: true
end
