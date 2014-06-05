class Video < ActiveRecord::Base
	require 'fileutils'
	has_many :viewings, dependent: :destroy
	belongs_to :topic

	def imageFile=(inputData)
		self.filename = inputData.original_filename
		if self.topic.nil?
			if Topic.last.blank?
				id = 1
			else
				id = Topic.last.id + 1
			end
		else
			id = self.topic.id
		end
		directory = "public/topics/#{id}/videos"
		FileUtils.mkdir_p(directory)
		File.open(File.join(directory, self.filename), "wb"){|f| f.write(inputData.read)}
	end
	
end
