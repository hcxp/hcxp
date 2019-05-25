class CrawlBandcampLinkJob < ApplicationJob
  queue_as :default

  def perform(link, event_id)
    event = Event.find(event_id)

    CrawlBandcampLink.run!(link: link, event: event)
  end
end
