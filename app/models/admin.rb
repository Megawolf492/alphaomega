class Admin < ActiveRecord::Base
	#validates :displayName, presence: true, length: {maximum: 40}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
				uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, on: :create, length: {minimum: 6}

	def Admin.newRememberToken
		SecureRandom.urlsafe_base64
	end

	def Admin.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

end
