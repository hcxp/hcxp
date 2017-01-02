class PostCardCell < ApplicationCell
  include ActionView::Helpers::DateHelper

  def show
    render
  end

  private

  def user
    model.user.decorate
  end

  def thumb
    if model.thumbnail.present?
      model.thumbnail.url
    else
      '//placehold.it/120x95'
    end
  end

  def title
    if model.crawled_at
      model.title || model.url
    else
      model.url
    end
  end

  def url
    model.url
  end

  def domain
    URI.parse(url).host.gsub('www.', '') rescue nil
  end
end
