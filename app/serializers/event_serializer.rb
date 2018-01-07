class EventSerializer < ActiveModel::Serializer
  include ActionView::Helpers::SanitizeHelper

  attributes :id, :name, :facebook_event_id, :start_at, :city, :country_code,
             :description, :description_html, :state, :poster_medium_url,
             :poster_large_url, :place_name

  def poster_medium_url
    object.poster.thumb('481x175#').url if object.poster_stored?
  end

  def poster_large_url
    object.poster.thumb('609x222#').url if object.poster_stored?
  end

  def description_html
    return '' unless object.description.present?

    desc = object.description
    desc = strip_tags(desc)
    desc = desc.gsub("\n", '<br/>')
    desc = Rinku.auto_link(desc)

    desc
  end
end
