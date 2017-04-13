class VenueDecorator < Draper::Decorator
  delegate_all

  def static_map_url(w = 100, h = 100, opts = {})
    center = [model.lat, model.lng].join(',')
    zoom = opts[:zoom] || 13

    options = {
      zoom:    zoom,
      size:    [w, h].join('x'),
      maptype: 'roadmap',
      center:  center,
      markers: "color:blue|#{center}",
      key:     ENV['GOOGLE_MAPS_STATIC_API_KEY']
    }

    options.merge!(opts)

    URI::HTTPS.build(
      host:  'maps.googleapis.com',
      path:  '/maps/api/staticmap',
      query: options.to_query
    )
  end

  def directions_url
    center = [model.lat, model.lng].join(',')
    "https://www.google.com/maps/dir/Current+Location/#{center}"
  end

end
