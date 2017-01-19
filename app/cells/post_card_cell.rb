class PostCardCell < ApplicationCell
  include ActionView::Helpers::DateHelper

  def show
    render
  end

  private

  def model_decor
    model.decorate
  end

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
    if model.crawled_at || model.text?
      model.title || model.url
    else
      model.url
    end
  end

  def url
    model.link? ? model.url : post_path(model)
  end

  def domain
    URI.parse(url).host.gsub('www.', '') rescue nil
  end

  def link_target
    model.link? ? '_blank' : false
  end
end
