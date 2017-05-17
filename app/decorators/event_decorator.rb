class EventDecorator < Draper::Decorator
  delegate_all

  def poster_url(width = 400, height = 500, opts = {})
    if model.poster.file.present?
      opts = {
        width:  width,
        height: height,
        fit_in: opts[:fit_in]
      }
      opts.merge!(filters: ['no_upscale()'])
      h.thumbor_url(model.poster.url, opts)
    else
      "https://placehold.it/#{width}x#{height}?text=#{opts[:text]}"
    end
  end

  def name_or_bands
    model.name.present? ? model.name : model.bands.map(&:name).join(', ')
  end

  def humanized_date
    time = h.time_ago_in_words(model.beginning_at)

    if model.beginning_at.today?
      text = [h.t('today')]
    elsif model.beginning_at.to_date == Date.tomorrow
      text = [h.t('tomorrow')]
    elsif model.beginning_at.to_date == Date.yesterday
      text = [h.t('yesterday')]
    elsif model.beginning_at > Time.zone.now
      text = [h.t('time_ago_in_words_in', default: 'In'), time]
    else
      text = [time, h.t('ago')]
    end

    text.join(' ')
  end

  def public_html_path(opts = {})
    args = { slug: slug }.merge!(opts)
    h.event_slugged_path(model.id, args)
  end

  def public_html_url(opts = {})
    args = { slug: slug }.merge!(opts)
    h.event_slugged_url(model.id, args)
  end

  def meta_tags
    {
      title: name_or_bands,
      og: {
        image: poster_url(200, 200, text: 'x')
      }
    }
  end

  def slug
    name_or_bands.to_slug.normalize.to_s
  end

  def google_calendar_link
    # - 2.hours is a dirty hack to persist a timezone difference (and it probably
    # works just for polish timezone). We need to do this in some smarter way.
    # Also - we need to do this cause google calendar url API does not accept
    # timezone suffix
    beginning_at = model.beginning_at - 2.hours
    beginning_at = beginning_at.iso8601.delete('-').delete(':')
    params = {
      action:   'TEMPLATE',
      text:     name_or_bands,
      details:  [model.bands.map(&:name).join(', '), public_html_url].reject(&:nil?).join("\n\n"),
      location: (model.venue.address rescue 'TBA'),
      dates:    [beginning_at, beginning_at].join('/')
    }

    URI::HTTPS.build(host: 'www.google.com', path: '/calendar/render', query: params.to_query)
  end
end
