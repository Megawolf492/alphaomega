class StaticPagesController < ApplicationController
	include AdminsHelper
	include StudentsHelper
	include TutorsHelper
	def home
		if adminSignedIn?
			@admin = currentAdmin
			@certifications = Certification.where(status: 1)
			render "admins/show"
		elsif tutorSignedIn?
			@tutor = currentTutor
			@certs = Certification.where(tutor_id: @tutor.id)
			@session = Session.new
			render "tutors/show"
		elsif studentSignedIn?
			@student = currentStudent
			@numVideos = Video.count
			@numViews = Viewing.where(student_id: @student.id).count
			@percentage = (@numViews.to_f / @numVideos) * 100
			@quizzes = Quiz.all
			render "students/show"
		end
	end

	def signup
		@tutor = Tutor.new
		@student = Student.new
	end

	def about

	end

	def links

	end
end
