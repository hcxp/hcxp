class EventBand < ApplicationRecord
  belongs_to :event
  belongs_to :band

  after_create :increment_band_events_count
  after_destroy :decrement_band_events_count

  private

  def increment_band_events_count
    logger.debug "Increment events_count for #{band}"
    band.increment!(:events_count)
  end

  def decrement_band_events_count
    logger.debug "Decrement events_count for #{band}"
    band.decrement!(:events_count)
  end
end
