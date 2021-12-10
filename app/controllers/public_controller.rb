class PublicController < ApplicationController

	def landing

		# handle work orders
		work_orders = WorkOrder.all
		@valid_orders, invalid_orders = work_orders.partition { |work_order| work_order.is_valid? }
		@valid_orders_by_tech = @valid_orders.group_by { | order | order.technician }

		# handle timescale
		tod_range_ints = HourRange::generate(@valid_orders)
		@tod_range_pretty = tod_range_ints.map { |i| helpers.prettify_tod_hour(i) }

		# handle work order css calculations (absolute value and height)
		@valid_orders_css = WorkOrderCss::generate(@valid_orders)

		# handle free time css calculations
		@free_time_hash = FreeTimeCss::generate(@valid_orders_css)

	end

end
