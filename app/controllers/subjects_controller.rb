class SubjectsController < ApplicationController
	include TutorsHelper
	#before_action :correctSubject, only: [:edit, :update, :destroy]

	def new
		@subject = Subject.new
		@department = Department.find(params[:department_id])
	end

	def create
		@subject = Subject.new(subjectParams)
		if @subject.save
			flash[:success] = "Subject Created!"
			redirect_to root_path
		else
			render 'new'
		end
	end	

	def show
		@subject = Subject.find(params[:id])
		@topics = @subject.topics
		if tutorSignedIn?
			@certification = Certification.where(subject_id: @subject.id, 
												tutor_id: currentTutor.id).first
		end
	end

	def edit
		@subject = Subject.find(params[:id])
		/@department = Department.find(params[:department_id])/
		if @subject.quiz == nil
			@subject.build_quiz
		end
	end

	def update
		@subject = Subject.find(params[:id])
		/@department = Department.find(params[:department_id])/
		if @subject.update_attributes(subjectParams)
			flash[:success] = "Profile Updated"
			redirect_to @subject
		else
			render 'edit'
		end
	end

	def destroy
		@subject = Subject.find(params[:id]).destroy
		flash[:success] = "Subject Deleted"
		redirect_to root_path
	end

	private

		def subjectParams
			params.require(:subject).permit(:time, :location, :duration, :price, :tutorNote, 
				topics_attributes: [:id, :name, :description, :_destroy,
					videos_attributes: [:id, :name, :topic_id, :imageFile, :_destroy],
					worksheets_attributes: [:id, :name, :pdfFile, :topic_id, :_destroy],
					quizzes_attributes: [:id, :name, :quizParent, :_destroy]],
				quiz_attributes: [:id, :name, :quizParent, :_destroy])
		end
end