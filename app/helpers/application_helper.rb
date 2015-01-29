module ApplicationHelper
	def filter_class(filter)
		params[:sort] == filter	? 'label-warning' : 'label-default'
	end
end
