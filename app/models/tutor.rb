class Tutor < ActiveRecord::Base
	require 'fileutils'
	has_many :certifications, dependent: :destroy
	has_many :sessions, dependent: :destroy

	validates :displayName, presence: true, length: {maximum: 40}
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

	def resumeFile=(inputData)
		self.fileName = inputData.original_filename
		
		id = self.id
		
		directory = "public/tutors/#{id}"
		FileUtils.mkdir_p(directory)
		File.open(File.join(directory, self.fileName), "wb"){|f| f.write(inputData.read)}
	end
end
