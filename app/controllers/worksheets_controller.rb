class WorksheetsController < ApplicationController

	def show
		worksheet = Worksheet.find(params[:id])
		pdfFilename = File.join("public/topics/#{worksheet.topic.id}/worksheets", worksheet.filename)
		send_file(pdfFilename, filename: worksheet.filename, disposition: 'inline', type: "application/pdf")
	end

end