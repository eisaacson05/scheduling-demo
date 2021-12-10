module WorkOrderCss

	def self.generate(orders)

		# offset adjusts for origin not starting at beginning of day
		y_offset = self.calc_y_offset(orders)
		tops = orders.map { |order| self.calc_top(order, y_offset) }
		heights = orders.map { |order| self.css_height(order) }

		# match on id in view for rendering
		# [{top: a, height: b, id: c }, ...]
		[tops, heights, orders].transpose.map { |t, h, o|  {top: t, height: h, technician_id: o.technician_id} }
	end

	private

	def self.calc_y_offset(orders)
		first_hour = orders.map { |order| order.time }.sort.first.hour
		first_hour * Constants::PIXELS_Y_PER_HOUR
	end

	def self.calc_top(order, y_offset)
		pix_min = (order.time.min * Constants::PIXELS_Y_PER_MINUTE)
		pix_hr = (order.time.hour * Constants::PIXELS_Y_PER_HOUR)
		pix_min + pix_hr - y_offset
	end

	def self.css_height(order)
		(order.duration.to_f / Constants::MINUTES_PER_HOUR.to_f) * Constants::PIXELS_Y_PER_HOUR
	end
end