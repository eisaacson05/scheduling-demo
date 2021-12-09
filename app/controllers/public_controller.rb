class PublicController < ApplicationController

	def landing
		@work_orders = WorkOrder.all
		@technicians = Technician.all
		@tod_range = ScheduleService::tod_range(@work_orders)
	end

end
