class QuizzesController < ApplicationController
	include AdminsHelper
	include UsersHelper
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

		if userSignedIn?
			grade = Grade.new
			grade.average = fGrade
			grade.user_id = currentUser.id
			grade.quiz_id = params[:id]
			grade.difficulty = params[:difficulty]
			grade.save
		end

		redirect_to topic_path
	end

	def show
		@quiz = Quiz.find(params[:id])
		if adminSignedIn?
			@easy = @quiz.questions.where(difficulty: "easy")
			@med = @quiz.questions.where(difficulty: "med")
			@hard = @quiz.questions.where(difficulty: "hard")
			render 'show'
		else
			redirect_to topic_path(@quiz.topic_id) and return if params[:difficulty].blank?
			@difficulty = params[:difficulty]
			@questions = @quiz.questions.where(difficulty: @difficulty).limit(5).order("RANDOM()")
			@counter = 0
			if @difficulty == "hard"
				render 'takeHardQuiz'
			else
				render 'takeQuiz'
			end
		end
	end

	def edit
		@quiz = Quiz.find(params[:id])
		@easy = @quiz.questions.where(difficulty: "easy")
		@med = @quiz.questions.where(difficulty: "med")
		@hard = @quiz.questions.where(difficulty: "hard")
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
				questions_attributes: [:id, :text, :maxValue, :difficulty, :_destroy,
					answers_attributes: [:id, :text, :value, :_destroy]])
		end
end