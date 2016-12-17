class EventDecorator < Draper::Decorator
  delegate_all

  def poster_url(w = 400, h = 500, opts = {})
    if model.poster.present?
      model.poster.url
    else
      "https://placehold.it/#{w}x#{h}?text=#{opts[:text]}"
    end
  end
end
