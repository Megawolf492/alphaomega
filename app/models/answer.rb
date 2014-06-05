class Answer < ActiveRecord::Base
	belongs_to :question

	validates :text, presence: true, length: {maximum: 100}
end
