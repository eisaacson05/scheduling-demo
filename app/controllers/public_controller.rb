class PublicController < ApplicationController

	MINUTES_PER_HOUR = 60

	def landing
		@work_orders = WorkOrder.all
		@tod_range = self.tod_range(@work_orders)
	end

	def tod_range(orders)
		first_tod = orders.map {|order| order.time.hour }.sort.first
		last_tod = orders.map {|order| order.time.hour + order.duration / MINUTES_PER_HOUR }.sort.last
		(first_tod..last_tod).to_a
	end

end
