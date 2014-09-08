class QuizzesController < ApplicationController
	include AdminsHelper
	include StudentsHelper
	include TutorsHelper
	before_action :adminSignedIn, except: [:show, :grade]

	def grade
		@quiz = Quiz.find(params[:id])
		@subject = @quiz.quizParent
		aGrade = 0.0
		pGrade = 0.0
		@fGrade = 0.0
		count = 0
		@iAnswers = Array.new(5)
		@numI = 0
		while count < 5
			correct = false 
			question = Question.find(params[("id" + count.to_s)])
			pGrade += question.maxValue
			question.answers.each do |answer|
				if answer.text == params[("guess" + count.to_s)]
					aGrade += answer.value
					correct = true
					break
				end
			end
			if !correct
				@iAnswers[@numI] = question
				@numI += 1
			end
			count += 1
		end
		@fGrade = (aGrade / pGrade * 100).round(2)
		flash[:success] = "Your grade is " + @fGrade.to_s + "%"

		if studentSignedIn?
			grade = Grade.new
			grade.average = @fGrade
			grade.student_id = currentStudent.id
			grade.quiz_id = params[:id]
			grade.save
		end

		if tutorSignedIn? && @subject.department != nil
			cert = Certification.find_or_initialize_by(subject_id: @subject.id, 
														tutor_id: currentTutor.id)
			if cert.grade.nil? || @fGrade > cert.grade
				cert.grade = @fGrade
			end
			if cert.grade >= 80.0
				cert.status = 1
			end
			cert.save
		end
	end

	def show
		@quiz = Quiz.find(params[:id])
		@parent = @quiz.quizParent
		if adminSignedIn?
			@questions = @quiz.questions
			render 'show'
		else
			if @parent.class.name.downcase == "subject"
				if tutorSignedIn?
					@questions = @quiz.questions.limit(5).order("RANDOM()")
					@counter = 0
					render 'takeQuiz'
				else
					redirect_to root_path
				end
			else
				@questions = @quiz.questions.limit(5).order("RANDOM()")
				@counter = 0
				render 'takeQuiz'
			end
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