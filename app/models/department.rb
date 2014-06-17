class Department < ActiveRecord::Base
	has_many :subjects, dependent: :destroy

	accepts_nested_attributes_for :subjects, allow_destroy: true
end
