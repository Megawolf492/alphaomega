class Tutor < ActiveRecord::Base
	validates :firstName, presence: true, length: {maximum: 40}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
				uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, on: :create, length: {minimum: 6}

	def Tutor.newRememberToken
		SecureRandom.urlsafe_base64
	end

	def Tutor.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end
end
