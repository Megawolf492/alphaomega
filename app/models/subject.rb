class Subject < ActiveRecord::Base
	has_many :topics, dependent: :destroy
	has_many :certifications, dependent: :destroy
end
