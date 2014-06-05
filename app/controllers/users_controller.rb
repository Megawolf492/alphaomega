class UsersController < ApplicationController
	include UsersHelper
	include AdminsHelper
	before_action :correctUser, only: [:edit, :update, :destroy]

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@numVideos = Video.all.count
		@numViews = Viewing.where(user_id: @user.id).count
		@percentage = (@numViews.to_f / @numVideos) * 100
		@quizzes = Quiz.all
		@easyAverage = 0
		@medAverage = 0
		@hardAverage = 0
		@numQuiz = 0
		@quizzes.each do |quiz|
			grades = quiz.grades.where(user_id: params[:id])
			if !grades.find(difficulty: "easy").nil?
				@easyAverage += grades.where(difficulty: "easy").order(average: :desc).first.average
			end
			if !grades.find(difficulty: "med").nil?
				@medAverage += grades.where(difficulty: "med").order(average: :desc).first.average
			end
			if !grades.find(difficulty: "hard").nil?
				@hardAverage += grades.where(difficulty: "hard").order(average: :desc).first.average
			end
			@numQuiz += 1
		end
		@easyAverage /= @numQuiz
		@medAverage /= @numQuiz
		@hardAverage /= @numQuiz
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(userParams)
		if @user.save
			flash[:success] = "Welcome to the Tutor App!"
			if !adminSignedIn?
				signInUser(@user)
			end
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(userParams)
			flash[:success] = "Profile Updated"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		@user = User.find(params[:id]).destroy
		flash[:success] = "User Deleted"
		redirect_to root_path
	end



	def signin
		user = User.find_by(email: params[:user][:email].downcase)
		if user && user.authenticate(params[:user][:password])
			signInUser user
			respond_to do |format|
				format.js {render action: "signinU"}
			end
		else 
			admin = Admin.find_by(email: params[:user][:email].downcase)
			if admin && admin.authenticate(params[:user][:password])
				signInAdmin admin
				respond_to do |format|
					format.js {render action: "signinA"}
				end
			else
				flash[:error] = "Invalid email or password"
				redirect_to root_path
			end
		end
	end

	def signout
		#works for both users and admins
		signOutUser
		respond_to do |format|
			format.js {render action: "signoutAll"}
		end
	end

	private

		def correctUser
			redirect_to root_path unless User.find(params[:id]) == currentUser || adminSignedIn?
		end

		def userParams
			params.require(:user).permit(:name, :email,
				:password, :password_confirmation)
		end

		def signInUser(user)
			rememberToken = User.newRememberToken
			cookies[:remember_token] = rememberToken
			#change to cookies.permanent to make cookie stay after browser close
			user.update_attribute(:remember_token, User.digest(rememberToken))
		end

		def signInAdmin(admin)
			rememberToken = Admin.newRememberToken
			cookies[:remember_token] = rememberToken
			#change to cookies.permanent to make cookie stay after browser close
			admin.update_attribute(:remember_token, Admin.digest(rememberToken))
		end

		def signOutUser
			#Works for both users and admins
			cookies.delete(:remember_token)
		end
end