module ScheduleService

	MINUTES_PER_HOUR = 60
	PIXELS_Y_PER_HOUR_ROW = 75

	def self.tod_range(orders)
		first_tod = orders.map {|order| order.time.hour }.sort.first
		last_tod = orders.map {|order| order.time.hour + order.duration / MINUTES_PER_HOUR }.sort.last
		(first_tod..last_tod).to_a
	end

	def self.prettify_tod_hour(hour_integer)
		Time.at(hour_integer.hours).utc.strftime("%l:%M %p")
	end

end