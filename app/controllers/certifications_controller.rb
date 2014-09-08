class CertificationsController < ApplicationController
	include AdminsHelper
	def certify
		cert = Certification.find(params[:id])
		cert.status = 2
		cert.save
		redirect_to admin_path(currentAdmin)
	end

end