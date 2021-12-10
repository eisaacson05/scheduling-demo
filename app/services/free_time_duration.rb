module FreeTimeDuration

	# Adds duration of free times to the free time data hash
	# returns hash {tech_id: [{ top: t, height: h, duration: d }, { top: t2, height: h2, duration: d2 }, ...]}
	#
	def self.generate(free_time_hash, tod_range_ints)
		free_time_hash.map do |tech_id, data|
			[tech_id, self.generate_by_technician(data, tod_range_ints)]
		end.to_h
	end

	private

	# Does not have to be ordered, since absolute value
	#
	def self.generate_by_technician(css_array, tod_range_ints)

		# the durations before and after work are special cases
		# determined by beginning and end of work day
		durations = css_array[1..-2].map { |css| duration_minutes(css) }
		durations = durations.prepend self.duration_before_work(css_array.first, tod_range_ints)
		durations = durations.append self.duration_after_work(css_array.last, tod_range_ints)

		# make pretty
		durations = durations.map { |min| self.duration_display_text(min) }

		# add duration to css attributes
		[css_array, durations].transpose.map {|css, duration|  css.merge({duration: duration}) }
	end

	def self.duration_minutes(css)
		css[:height] / Constants::PIXELS_Y_PER_MINUTE
	end

	def self.duration_before_work(css, tod_range_ints)
		work_hours_before_origin = tod_range_ints.first - Constants::BEGINNING_OF_WORK_DAY_HR
		pix_before_origin = work_hours_before_origin * Constants::PIXELS_Y_PER_HOUR
		height_from_workday_start = css[:height] + pix_before_origin
		height_from_workday_start.to_f / Constants::PIXELS_Y_PER_MINUTE
	end

	def self.duration_after_work(css, tod_range_ints)
		pix_before_origin = tod_range_ints.first * Constants::PIXELS_Y_PER_HOUR
		pix_to_end_of_workday = Constants::END_OF_WORK_DAY_HR * Constants::PIXELS_Y_PER_HOUR
		top_from_workday_start = css[:top] + pix_before_origin
		(pix_to_end_of_workday - top_from_workday_start) / Constants::PIXELS_Y_PER_MINUTE
	end

	def self.duration_display_text(min)
		Time.at(min * Constants::SECONDS_PER_MINUTE).utc.strftime("%khr %Mmin")
	end
end