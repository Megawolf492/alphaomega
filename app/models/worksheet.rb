class Worksheet < ActiveRecord::Base
	require 'fileutils'
	belongs_to :topic

	def pdfFile=(inputData)
		self.filename = inputData.original_filename
		if self.topic.nil?
			if Topic.last.nil?
				id = 1
			else
				id = Topic.last.id + 1
			end
		else
			id = self.topic.id
		end
		directory = "public/topics/#{id}/worksheets"
		FileUtils.mkdir_p(directory)
		File.open(File.join(directory, self.filename), "wb"){|f| f.write(inputData.read)}
	end
end
