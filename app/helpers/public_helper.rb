module PublicHelper

	# Do misc tasks here
	#

	def prettify_tod_hour(hour_integer)
		Time.at(hour_integer.hours).utc.strftime("%l:%M %p")
	end

	def prettify_time_available(min)
		Time.at(min).utc.strftime("%khr %Mmin")
	end
end