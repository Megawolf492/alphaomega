class StudentsController < ApplicationController
	include StudentsHelper
	include AdminsHelper
	before_action :correctStudent, only: [:edit, :update, :destroy]

	def index
		@students = Student.all
	end

	def show
		@student = Student.find(params[:id])
		@numVideos = Video.all.count
		@numViews = Viewing.where(student_id: @student.id).count
		@percentage = (@numViews.to_f / @numVideos) * 100
		@quizzes = Quiz.all
	end

	def new
		@student = Student.new
	end

	def create
		@student = Student.new(studentParams)
		if @student.save
			flash[:success] = "Welcome to the Tutor App!"
			if !adminSignedIn?
				signInStudent(@student)
			end
			redirect_to @student
		else
			render 'new'
		end
	end

	def edit
		@student = Student.find(params[:id])
	end

	def update
		@student = Student.find(params[:id])
		if @student.update_attributes(studentParams)
			flash[:success] = "Profile Updated"
			redirect_to @student
		else
			render 'edit'
		end
	end

	def destroy
		@student = Student.find(params[:id]).destroy
		flash[:success] = "Student Deleted"
		redirect_to root_path
	end



	def signin
		student = Student.find_by(email: params[:student][:email].downcase)
		if student && student.authenticate(params[:student][:password])
			signInStudent student
			redirect_to student_path(student)
		else 
			tutor = Tutor.find_by(email: params[:student][:email].downcase)
			if tutor && tutor.authenticate(params[:student][:password])
				signInTutor tutor
				redirect_to tutor_path(tutor)
			else
				admin = Admin.find_by(email: params[:student][:email].downcase)
				if admin && admin.authenticate(params[:student][:password])
					signInAdmin admin
					redirect_to admin_path(admin)
				else
					flash[:error] = "Invalid email or password"
					redirect_to root_path
				end
			end
		end
	end

	def signout
		#works for students tutors and admins
		signOutStudent
		respond_to do |format|
			format.js {render action: "signoutAll"}
		end
	end

	private

		def correctStudent
			redirect_to root_path unless Student.find(params[:id]) == currentStudent || adminSignedIn?
		end

		def studentParams
			params.require(:student).permit(:displayName, :realName, :email, :street,
				:city, :state, :zipcode, :phone, :dob, :gender, :biography,
				:password, :password_confirmation)
		end

		def signInStudent(student)
			rememberToken = Student.newRememberToken
			cookies[:remember_token] = rememberToken
			#change to cookies.permanent to make cookie stay after browser close
			student.update_attribute(:remember_token, Student.digest(rememberToken))
		end

		def signInTutor(tutor)
			rememberToken = Tutor.newRememberToken
			cookies[:remember_token] = rememberToken
			#change to cookies.permanent to make cookie stay after browser close
			tutor.update_attribute(:remember_token, Tutor.digest(rememberToken))
		end

		def signInAdmin(admin)
			rememberToken = Admin.newRememberToken
			cookies[:remember_token] = rememberToken
			#change to cookies.permanent to make cookie stay after browser close
			admin.update_attribute(:remember_token, Admin.digest(rememberToken))
		end

		def signOutStudent
			#Works for students tutors and admins
			cookies.delete(:remember_token)
		end
end