class EventDecorator < Draper::Decorator
  delegate_all

  def poster_url(width = 400, height = 500, opts = {})
    if model.poster.present?
      opts = { width: width, height: height }
      opts.merge!(filters: ['no_upscale()'])
      h.thumbor_url(model.poster.url, opts)
    else
      "https://placehold.it/#{width}x#{height}?text=#{opts[:text]}"
    end
  end
end
