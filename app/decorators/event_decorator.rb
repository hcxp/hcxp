class EventDecorator < Draper::Decorator
  delegate_all

  def to_s
    name_or_bands
  end

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

  def search_label
    parts = [name_or_bands]
    parts << venue.name if venue
    parts << venue.city if venue
    parts.join(', ')
  end

  def public_html_path
    h.event_path(model)
  end

  def meta_tags
    {
      title: name_or_bands,
      og: {
        image: poster_url(200, 200, text: 'x')
      }
    }
  end
end
