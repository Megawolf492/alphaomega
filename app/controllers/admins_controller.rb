class AdminsController < ApplicationController
	include AdminsHelper
	before_action :adminSignedIn
	before_action :correctAdmin, only: [:edit, :update, :destroy]

	def new
		@admin = Admin.new
	end

	def create
		@admin = Admin.new(adminParams)
		if @admin.save
			flash[:success] = "Admin Created!"
			redirect_to root_path
		else
			render 'new'
		end
	end	

	def index
		@admins = Admin.all
	end

	def show
		@admin = Admin.find(params[:id])
		@certifications = Certification.where(status: 1)
	end

	def edit
		@admin = Admin.find(params[:id])
	end

	def update
		@admin = Admin.find(params[:id])
		if @admin.update_attributes(adminParams)
			flash[:success] = "Profile Updated"
			redirect_to @admin
		else
			render 'edit'
		end
	end

	def destroy
		@admin = Admin.find(params[:id]).destroy
		flash[:success] = "Admin Deleted"
		redirect_to root_path
	end

	private

		def correctAdmin
			redirect_to root_path unless Admin.find(params[:id]) == currentAdmin
		end

		def adminParams
			params.require(:admin).permit(:displayName, :realName, :email,
				:dob, :gender, :biography, :password, :password_confirmation)
		end
end