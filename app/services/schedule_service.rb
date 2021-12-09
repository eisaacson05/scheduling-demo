module ScheduleService

	MINUTES_PER_HOUR = 60
	PIXELS_Y_PER_HOUR_ROW = 75

	# get an integer list representing hours valid to display on the schedule grid
	#
	def self.tod_range(orders)
		first_tod = orders.map {|order| order.time.hour }.sort.first
		last_tod = orders.map {|order| order.time.hour + order.duration / MINUTES_PER_HOUR }.sort.last
		(first_tod..last_tod).to_a
	end

	# pretty string for integer in tod_range
	#
	def self.prettify_tod_hour(hour_integer)
		Time.at(hour_integer.hours).utc.strftime("%l:%M %p")
	end

	# get css for absolute positioned schedule items
	#
	def self.css_for_work_order(work_order, first_tod)
		top = (work_order.time.hour - first_tod) * PIXELS_Y_PER_HOUR_ROW
		height = (work_order.duration.to_f / MINUTES_PER_HOUR.to_f) * PIXELS_Y_PER_HOUR_ROW
		"top: #{ top }px; height: #{ height }px"
	end

end