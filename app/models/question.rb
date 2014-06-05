class Question < ActiveRecord::Base
	belongs_to :quiz
	has_many :answers, dependent: :destroy

	validates :text, presence: true, length: {maximum: 1000}
	accepts_nested_attributes_for :answers, allow_destroy: true
end
