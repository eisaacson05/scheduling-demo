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

	# get css for absolute positioned work orders
	#
	def self.css_for_work_order(work_order, first_tod)
		top = (work_order.time.hour - first_tod) * PIXELS_Y_PER_HOUR_ROW
		height = (work_order.duration.to_f / MINUTES_PER_HOUR.to_f) * PIXELS_Y_PER_HOUR_ROW
	end

	# get css for absolute positioned free times
	#
	def self.free_times(work_orders, first_hour)
		work_orders = work_orders.sort_by  { |item| item.time}
		[
			self.free_time_before_orders(work_orders.first, first_hour),
			*self.free_times_between_orders(work_orders, first_hour),
			self.free_time_after_orders(work_orders.last, first_hour)
		]
	end

	def self.free_time_before_orders(first_order, first_hour)
		height= first_order.css_top(first_hour)
		{
			css: "top: 0px; height: #{ height }px",
			time_between_orders: "" # TODO
		}
	end

	def self.free_times_between_orders(work_orders, first_hour)
		work_orders.each_cons(2).map do | order_prev, order |
			top = order_prev.css_top(first_hour) + order_prev.css_height
			height = order.css_top(first_hour) - top
			{
				css: "top: #{ top }px; height: #{ height }px",
				time_between_orders: "" # TODO
			}
		end
	end

	def self.free_time_after_orders(last_order, first_hour)
		top = last_order.css_top(first_hour) + last_order.css_height
		{
			css: "top: #{ top }px; bottom: 0px",
			time_between_orders: "" # TODO
		}
	end
end