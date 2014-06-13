class VideosController < ApplicationController
	include StudentsHelper
	def show
		@video = Video.find(params[:id])
		@topic = @video.topic
		if !currentStudent.nil? && !currentStudent.viewed?(@video)
			currentStudent.viewed!(@video)
			@viewed = false
		else
			@viewed = true
		end
	end
end