class WorkOrder < ApplicationRecord
  belongs_to :technician
  belongs_to :location

  def end
    self.time + self.duration.minutes
  end

  def pretty_tod
    self.time.utc.strftime("%l:%M %p")
  end

  def pretty_price
    "$%05.2f" % self.price
  end

  def css_top(first_hour)
    minutes = (self.time.hour * ScheduleService::MINUTES_PER_HOUR) + self.time.min
    minutes_offset = first_hour * ScheduleService::MINUTES_PER_HOUR # need to account for starting later than beginning of day
    (minutes - minutes_offset).to_f / ScheduleService::MINUTES_PER_HOUR * ScheduleService::PIXELS_Y_PER_HOUR_ROW
  end

  def css_height
    (self.duration.to_f / ScheduleService::MINUTES_PER_HOUR.to_f) * ScheduleService::PIXELS_Y_PER_HOUR_ROW
  end

end
