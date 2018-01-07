class Events::AddFromFacebook < ActiveInteraction::Base
  string :link

  validates :link, presence: true
  validates :link, url: { no_local: true }, allow_blank: true
  validate :validate_from_facebook

  def execute
    event = Event.find_by(facebook_event_id: facebook_id_from_link)

    unless event.present?
      event = Event.create(
        state: 'new',
        facebook_event_id: facebook_id_from_link
      )
      SyncEventFacebookDataJob.perform_later(event.id)
    end

    event
  end

  private

  def validate_from_facebook
    return if link.blank?
    return if link =~ %r{^http(s)://(www.)facebook.com/events/\d+}

    errors.add(:link, :not_facebook_event)
  end

  def facebook_id_from_link
    link[%r{events/(\d+)}, 1]
  end
end
