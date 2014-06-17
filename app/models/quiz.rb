class Quiz < ActiveRecord::Base
	has_many :questions, dependent: :destroy
	has_many :grades #,dependent: :destroy????
	belongs_to :quizParent, polymorphic: true

	validates :name, presence: true, length: {maximum: 40}
	accepts_nested_attributes_for :questions, allow_destroy: true
end
