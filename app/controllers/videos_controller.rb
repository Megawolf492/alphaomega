class VideosController < ApplicationController
	include UsersHelper
	def show
		@video = Video.find(params[:id])
		@topic = @video.topic
		if !currentUser.nil? && !currentUser.viewed?(@video)
			currentUser.viewed!(@video)
			@viewed = false
		else
			@viewed = true
		end
	end
end