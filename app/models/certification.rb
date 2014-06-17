class Certification < ActiveRecord::Base
	belongs_to :subject
	belongs_to :tutor
end
