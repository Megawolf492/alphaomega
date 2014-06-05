class TopicsController < ApplicationController
	include AdminsHelper
	before_action :adminSignedIn, except: [:index, :show]

	def index
		@topics = Topic.all
	end

	def show
		@topic = Topic.find(params[:id])
		@videos = @topic.videos
		@video = @videos.first
		@worksheets = @topic.worksheets
		@quizzes = @topic.quizzes
	end

	def new
		@topic = Topic.new
		@videos = @topic.videos
		@worksheets = @topic.worksheets
		@quizzes = @topic.quizzes
	end

	def create
		@topic = Topic.new(topicParams)
		if @topic.save
			flash[:success] = "Topic Created"
			redirect_to @topic
		else
			render 'new'
		end
	end

	def edit
		@topic = Topic.find(params[:id])
		@videos = @topic.videos
		@worksheets = @topic.worksheets
		@quizzes = @topic.quizzes
	end

	def update
		@topic = Topic.find(params[:id])
		if @topic.update_attributes(topicParams)
			flash[:success] = "Topic Updated"
			redirect_to @topic
		else
			flash[:failure] = "Topic not updated"
			render 'edit'
		end
	end

	def destroy
		@topic = Topic.find(params[:id]).destroy
		flash[:success] = "Topic Deleted"
		redirect_to root_path
	end

	private

		def topicParams
			params.require(:topic).permit(:name, :description, 
				videos_attributes: [:id, :name, :topic_id, :imageFile, :_destroy],
				worksheets_attributes: [:id, :name, :pdfFile, :topic_id, :_destroy],
				quizzes_attributes: [:id, :name, :topic_id, :_destroy])
		end
end