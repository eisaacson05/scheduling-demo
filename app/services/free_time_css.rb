module FreeTimeCss

	# returns hash {tech_id: [{ top: t, height: h }, { top: t2, height: h2 }, ...]}
	#
	def self.generate(work_order_css)
		work_orders_by_tech = work_order_css.group_by  { |item| item[:technician_id] }
		work_orders_by_tech.map do |tech_id, order_css|
			[tech_id, self.generate_by_technician(order_css)]
		end.to_h
	end

	private

	def self.generate_by_technician(order_css)
		order_css = order_css.sort_by { | order | order[:top] }
		tops = self.calc_tops(order_css)
		heights = self.calc_heights(order_css)

		# the free times before and after work are special cases
		tops = tops.prepend self.top_before_work
		tops = tops.append self.top_after_work(order_css.last)
		heights = heights.prepend self.height_before_work(order_css.first)
		heights = heights.append self.height_after_work

		[tops, heights].transpose.map { | t, h |  { top: t, height: h } }
	end

	def self.calc_tops(work_order_css)
		work_order_css.each_cons(2).map do | css_prev, css |
			css_prev[:top] + css_prev[:height]
		end
	end

	def self.calc_heights(work_order_css)
		work_order_css.each_cons(2).map do | css_prev, css |
			css[:top] - css_prev[:height] - css_prev[:top]
		end
	end

	def self.top_before_work
		0
	end

	def self.top_after_work(last_css)
		last_css[:top] + last_css[:height]
	end

	def self.height_before_work(first_css)
		first_css[:top]
	end

	# no height for final free time, we use bottom: 0px
	def self.height_after_work
		nil
	end
end