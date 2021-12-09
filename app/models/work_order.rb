class WorkOrder < ApplicationRecord
  belongs_to :technician
  belongs_to :location

  def pretty_tod
    self.time.utc.strftime("%l:%M %p")
  end

  def pretty_price
    "$%05.2f" % self.price
  end
end
