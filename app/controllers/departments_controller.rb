class DepartmentsController < ApplicationController
	#include DepartmentsHelper
	#before_action :correctDepartment, only: [:edit, :update, :destroy]

	def new
		@department = Department.new
	end

	def create
		@department = Department.new(departmentParams)
		if @department.save
			flash[:success] = "Department Created!"
			redirect_to root_path
		else
			render 'new'
		end
	end	

	def index
		@departments = Department.all
	end

	def show
		@department = Department.find(params[:id])
		@subjects = @department.subjects
	end

	def edit
		@department = Department.find(params[:id])
	end

	def update
		@department = Department.find(params[:id])
		if @department.update_attributes(departmentParams)
			flash[:success] = "Profile Updated"
			redirect_to @department
		else
			render 'edit'
		end
	end

	def destroy
		@department = Department.find(params[:id]).destroy
		flash[:success] = "Department Deleted"
		redirect_to root_path
	end

	private

		def departmentParams
			params.require(:department).permit(:name, subjects_attributes: [:id, :name, :_destroy])
		end
end