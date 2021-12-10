# Get valid days to display
#
module HourRange

	def self.generate(orders)
		first_tod = orders.map {|order| order.time.hour }.sort.first
		last_tod = orders.map {|order| order.time.hour + order.duration / Constants::MINUTES_PER_HOUR }.sort.last
		(first_tod..last_tod).to_a
	end

end