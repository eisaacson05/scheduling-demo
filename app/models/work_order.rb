class WorkOrder < ApplicationRecord

  belongs_to :technician
  belongs_to :location

  def end
    self.time + self.duration.minutes
  end

  def minutes_from_day_start
    (self.time.hour * Constants::MINUTES_PER_HOUR) + self.time.min
  end

  def pretty_tod
    self.time.utc.strftime("%l:%M %p")
  end

  def pretty_price
    "$%05.2f" % self.price
  end

  def is_valid?
    true
  end

end
