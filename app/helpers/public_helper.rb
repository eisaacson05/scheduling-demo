module PublicHelper

	# Do misc tasks here
	#

	def prettify_tod_hour(hour_integer)
		Time.at(hour_integer.hours).utc.strftime("%l:%M %p")
	end

end