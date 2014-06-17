class Subject < ActiveRecord::Base
	belongs_to :department
	has_many :topics, dependent: :destroy
	has_many :certifications, dependent: :destroy

	accepts_nested_attributes_for :topics, allow_destroy: true
end
