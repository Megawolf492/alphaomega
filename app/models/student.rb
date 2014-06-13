class Student < ActiveRecord::Base
	before_save {self.email = email.downcase}
	has_many :viewings, dependent: :destroy
	has_many :grades, dependent: :destroy
	has_many :videos, through: :viewings, dependent: :destroy

	validates :firstName, presence: true, length: {maximum: 40}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
				uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, length: {minimum: 6}

	def Student.newRememberToken
		SecureRandom.urlsafe_base64
	end

	def Student.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def viewed?(video)
		viewings.find_by(video_id: video.id)
	end

	def viewed!(video)
		viewings.create!(video_id: video.id)
	end
end
