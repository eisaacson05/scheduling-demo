class PublicController < ApplicationController

	MINUTES_PER_HOUR = 60

	def landing
		@work_orders = WorkOrder.all
		@tod_range = ScheduleService::tod_range(@work_orders)
	end



end
