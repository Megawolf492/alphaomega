module UsersHelper

	def userSignedIn?
		!currentUser.nil?
	end

	def currentUser
		rememberToken = User.digest(cookies[:remember_token])
		@currentUser ||= User.find_by(remember_token: rememberToken)
	end

	def gravatar(user, options = {size: 50})
		gravatarID = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		gravatarURL = "https://secure.gravatar.com/avatar/#{gravatarID}?s=#{size}"
		image_tag(gravatarURL, alt: user.firstName)
	end
end