class WorkOrder < ApplicationRecord
  belongs_to :technician
  belongs_to :location

  def pretty_tod
    self.time.utc.strftime("%l:%M %p")
  end

  def pretty_price
    "$%05.2f" % self.price
  end

  def css_top(first_hour)
    (self.time.hour - first_hour) * ScheduleService::PIXELS_Y_PER_HOUR_ROW
  end

  def css_height
    (self.duration.to_f / ScheduleService::MINUTES_PER_HOUR.to_f) * ScheduleService::PIXELS_Y_PER_HOUR_ROW
  end

end
