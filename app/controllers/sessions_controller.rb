class SessionsController < ApplicationController
	include TutorsHelper
	#before_action :correctSession, only: [:edit, :update, :destroy]

	def new
		@session = Session.new
		@tutor = currentTutor
		@certs = Certification.where(tutor: @tutor, status: 2)
		@students = currentTutor.students
	end

	def create
		@session = Session.new(sessionParams)
		if @session.save!
			flash[:success] = "Session Created!"
			redirect_to root_path
		else
			render 'new'
		end
	end

	def show
		@session = Session.find(params[:id])
	end

	def edit
		@session = Session.find(params[:id])
		@tutor = currentTutor
		@certs = Certification.where(tutor: @tutor, status: 2)
		@students = currentTutor.students
	end

	def update
		@session = Session.find(params[:id])
		if @session.update_attributes(sessionParams)
			flash[:success] = "Session Updated"
			redirect_to @session
		else
			render 'edit'
		end
	end

	def destroy
		@session = Session.find(params[:id]).destroy
		flash[:success] = "Session Deleted"
		redirect_to root_path
	end

	private

		def sessionParams
			params.require(:session).permit(:time, :location, :duration,
				:price, :tutorNote, :subjects, :students, :status, :tutor_id)
		end
end
