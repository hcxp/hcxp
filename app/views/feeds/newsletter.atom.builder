atom_feed do |feed|
  feed.title("Events next week / hcxp.co")
  feed.updated(@events[0].created_at) if @events.length > 0

  @events.each do |e, event = e.decorate|
    feed.entry(event, id: event.id) do |entry|
      entry.title        event.name_or_bands
      entry.beginning_at event.beginning_at.iso8601
      entry.bands        event.bands.map(&:name).uniq.join(', ')
      entry.venue        event.venue.name
      entry.address      event.venue.address
      entry.city         event.venue.city
      entry.country      event.venue.country_code
      entry.poster       event.poster_url
    end
  end
end