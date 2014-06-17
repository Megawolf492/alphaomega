class QuizzesController < ApplicationController
	include AdminsHelper
	include StudentsHelper
	before_action :adminSignedIn, except: [:show, :grade]

	def grade
		aGrade = 0.0
		pGrade = 0.0
		fGrade = 0.0
		count = 0
		while count < 5 
			question = Question.find(params[("id" + count.to_s)])
			pGrade += question.maxValue
			question.answers.each do |answer|
				if answer.text == params[("guess" + count.to_s)]
					aGrade += answer.value
					break
				end
			end
			count += 1
		end
		fGrade = (aGrade / pGrade * 100).round(2)
		flash[:success] = "Your grade is " + fGrade.to_s + "%"

		if studentSignedIn?
			grade = Grade.new
			grade.average = fGrade
			grade.student_id = currentStudent.id
			grade.quiz_id = params[:id]
			grade.save
		end

		redirect_to topic_path
	end

	def show
		@quiz = Quiz.find(params[:id])
		@topic = @quiz.quizParent
		if adminSignedIn?
			@questions = @quiz.questions
			render 'show'
		else
			@questions = @quiz.questions.limit(5).order("RANDOM()")
			@counter = 0
			render 'takeQuiz'
		end
	end

	def edit
		@quiz = Quiz.find(params[:id])
		@topic = @quiz.quizParent
	end

	def update
		@quiz = Quiz.find(params[:id])
		if @quiz.update_attributes(quizParams)
			flash[:success] = "Quiz Updated"
			redirect_to @quiz
		else
			render 'edit'
		end
	end

	private

		def quizParams
			params.require(:quiz).permit(:name, :topic_id,
				questions_attributes: [:id, :text, :maxValue, :_destroy,
					answers_attributes: [:id, :text, :value, :_destroy]])
		end
end