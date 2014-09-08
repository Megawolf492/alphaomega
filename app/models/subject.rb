class Subject < ActiveRecord::Base
	belongs_to :department
	has_many :topics, dependent: :destroy
	has_many :certifications, dependent: :destroy
	has_one :quiz, as: :quizParent, autosave: true, dependent: :destroy
	has_and_belongs_to_many :sessions

	

	accepts_nested_attributes_for :topics, allow_destroy: true
	accepts_nested_attributes_for :quiz, allow_destroy: true
end
