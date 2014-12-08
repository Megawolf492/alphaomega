class TutorsController < ApplicationController
	include TutorsHelper
	include AdminsHelper
	include StudentsHelper
	#before_action :tutorSignedIn
	before_action :correctTutor, only: [:edit, :update, :destroy]

	def new
		@tutor = Tutor.new
	end

	def create
		@tutor = Tutor.new(tutorParams)
		if @tutor.save
			flash[:success] = "Tutor Created!"
			if !adminSignedIn?
				signInTutor(@tutor)
			end
			redirect_to @tutor
		else
			render 'new'
		end
	end

	def index
		@tutors = Tutor.all
	end

	def show
		@tutor = Tutor.find(params[:id])
		if tutorSignedIn? && currentTutor == @tutor
			redirect_to root_path
		end
		@certs = Certification.where(tutor_id: @tutor.id)
		if studentSignedIn?
			@hired = Hiring.where(tutor: @tutor, student: currentStudent).first
		end
	end

	def edit
		@tutor = Tutor.find(params[:id])
	end

	def update
		@tutor = Tutor.find(params[:id])
		if @tutor.update_attributes(tutorParams)
			flash[:success] = "Profile Updated"
			redirect_to @tutor
		else
			render 'edit'
		end
	end

	def destroy
		@tutor = Tutor.find(params[:id]).destroy
		flash[:success] = "Tutor Deleted"
		redirect_to root_path
	end

	def resume
		tutor = Tutor.find(params[:id])
		pdfFilename = File.join("public/tutors/#{tutor.id}", tutor.fileName)
		send_file(pdfFilename, filename: tutor.fileName, disposition: 'inline', type: "application/pdf")
	end

	private

		def correctTutor
			redirect_to root_path unless Tutor.find(params[:id]) == currentTutor
		end

		def tutorParams
			params.require(:tutor).permit(:displayName, :realName, :email,
				:street, :city, :state, :zipcode, :phone, :dob, :gender,
				:wage, :biography, :resumeFile, :password, :password_confirmation)
		end
end
