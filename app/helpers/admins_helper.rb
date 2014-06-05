module AdminsHelper

	def adminSignedIn?
		!currentAdmin.nil?
	end

	def currentAdmin
		rememberToken = Admin.digest(cookies[:remember_token])
		@currentAdmin ||= Admin.find_by(remember_token: rememberToken)
	end

	def adminSignedIn
		redirect_to root_path unless adminSignedIn?
	end
end