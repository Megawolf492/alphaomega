module TutorsHelper

	def tutorSignedIn?
		!currentTutor.nil?
	end

	def currentTutor
		rememberToken = Tutor.digest(cookies[:remember_token])
		@currentTutor ||= Tutor.find_by(remember_token: rememberToken)
	end

	def tutorSignedIn
		redirect_to root_path unless tutorSignedIn?
	end

	def gravatar(tutor, options = {size: 50})
		gravatarID = Digest::MD5::hexdigest(tutor.email.downcase)
		size = options[:size]
		gravatarURL = "https://secure.gravatar.com/avatar/#{gravatarID}?s=#{size}"
		image_tag(gravatarURL, alt: tutor.firstName)
	end
end