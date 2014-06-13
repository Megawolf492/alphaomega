module StudentsHelper

	def studentSignedIn?
		!currentStudent.nil?
	end

	def currentStudent
		rememberToken = Student.digest(cookies[:remember_token])
		@currentStudent ||= Student.find_by(remember_token: rememberToken)
	end

	def gravatar(student, options = {size: 50})
		gravatarID = Digest::MD5::hexdigest(student.email.downcase)
		size = options[:size]
		gravatarURL = "https://secure.gravatar.com/avatar/#{gravatarID}?s=#{size}"
		image_tag(gravatarURL, alt: student.firstName)
	end
end