module ApplicationHelper
	def filter_class(filter)
		if params[:sort] == filter
			'label-warning'
		else
			'label-default'
		end
	end
end
