class BandSerializer < ActiveModel::Serializer
  attributes :id, :uid, :name, :location, :photo_small_url, :bandcamp_url,
             :description

  def photo_small_url
    object.photo.thumb('100x100#n').url if object.photo_stored?
  end

  def bandcamp_url
    URI::HTTPS.build(host: "#{object.uid}.bandcamp.com")
  end
end
