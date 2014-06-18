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

	def signInTutor(tutor)
		rememberToken = Tutor.newRememberToken
		cookies[:remember_token] = rememberToken
		#change to cookies.permanent to make cookie stay after browser close
		tutor.update_attribute(:remember_token, Tutor.digest(rememberToken))
	end

	def gravatar(tutor, options = {size: 50})
		gravatarID = Digest::MD5::hexdigest(tutor.email.downcase)
		size = options[:size]
		gravatarURL = "https://secure.gravatar.com/avatar/#{gravatarID}?s=#{size}"
		image_tag(gravatarURL, alt: tutor.displayName)
	end
end