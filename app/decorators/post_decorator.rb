class PostDecorator < Draper::Decorator
  delegate_all

  def thumbnail_url(width = 80, height = 80, opts = {})
    if model.thumbnail.present?
      opts = {
        width:  width,
        height: height,
        fit_in: opts[:fit_in]
      }
      opts.merge!(filters: ['no_upscale()'])
      h.thumbor_url(model.thumbnail.url, opts)
    else
      "https://placehold.it/#{width}x#{height}?text=#{opts[:text]}"
    end
  end

end
