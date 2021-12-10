class WorkOrder < ApplicationRecord

  belongs_to :technician
  belongs_to :location

  scope :long_title, -> { where("LENGTH(title) > 20") }

  def pretty_tod
    self.time.utc.strftime("%l:%M %p")
  end

  def pretty_price
    "$%05.2f" % self.price
  end

  def is_valid?
    all_scheduled_during.empty?
  end

  def all_scheduled_during
    WorkOrder.where({
      time: self.time..(self.time + self.duration.minutes),
      technician_id: self.technician_id
    }).where.not({
      id: self.id
    })
  end
end
