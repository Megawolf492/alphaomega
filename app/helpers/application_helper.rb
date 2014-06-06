module ApplicationHelper
	def fullTitle(pageTitle)
		baseTitle = "Ruby on Rails"
		if pageTitle.empty?
			baseTitle
		else
			"#{baseTitle} | #{pageTitle}"
		end
	end

	def fullPageBar(pageBar)
		baseBar = link_to "Home", root_path
		if pageBar.empty?
			baseBar
		else
			baseBar + " >" + pageBar
		end
	end
end
