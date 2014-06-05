module ApplicationHelper
	def fullTitle(pageTitle)
		baseTitle = "Ruby on Rails"
		if pageTitle.empty?
			baseTitle
		else
			"#{baseTitle} | #{pageTitle}"
		end
	end
end
