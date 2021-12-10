module ScheduleService

	MINUTES_PER_HOUR = 60
	PIXELS_Y_PER_HOUR_ROW = 75

	# TODO: these are assumptions
	BEGINNING_OF_WORK_DAY_HR=4.hours # 4am
	END_OF_WORK_DAY_HR=18.hours # 6pm

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
		available_minutes =  first_order.time - BEGINNING_OF_WORK_DAY_HR
		{
			css: "top: 0px; height: #{ height }px",
			time_available_pretty: "Time Available from Start of Day: #{ self.pretty_time_available(available_minutes) }"
		}
	end

	def self.free_times_between_orders(work_orders, first_hour)
		work_orders.each_cons(2).map do | order_prev, order |
			top = order_prev.css_top(first_hour) + order_prev.css_height
			height = order.css_top(first_hour) - top
			available_minutes = order.time - (order_prev.time + order_prev.duration.minutes)
			{
				css: "top: #{ top }px; height: #{ height }px",
				time_available_pretty: "Time Available: #{ self.pretty_time_available(available_minutes) }"
			}
		end
	end

	def self.free_time_after_orders(last_order, first_hour)
		top = last_order.css_top(first_hour) + last_order.css_height
		available_minutes =  (last_order.time.beginning_of_day + END_OF_WORK_DAY_HR) - last_order.end
		{
			css: "top: #{ top }px; bottom: 0px",
			time_available_pretty: "Time Available Until End of Day: #{ self.pretty_time_available(available_minutes) }"
		}
	end

	def self.pretty_time_available(min)
		Time.at(min).utc.strftime("%khr %Mmin")
	end
end